// Writes content/hadith/cited.json: the verbatim text of every hadith the
// content cites, from the pinned hadith-api editions (see HadithDataset).
//
//   dart run tool/hadith_extract.dart          # write the file
//   dart run tool/hadith_extract.dart --check  # is it up to date?
//
// The editions are downloaded once into .dart_tool/hadith/ and checked
// against their pinned SHA-256 before use. Only this tool goes online; the
// validator, the build and the app work from the committed file.
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/hadith_dataset.dart';

const cacheDir = '.dart_tool/hadith';

Future<void> main(List<String> args) async {
  requireProjectRoot();
  final check = args.contains('--check');
  final files = ContentFiles.fromDirectory(Directory('content'));

  final editions = <String, List<Map<String, dynamic>>>{};
  for (final MapEntry(key: source, value: (edition, sha))
      in HadithDataset.editions.entries) {
    final bytes = await _edition(edition);
    final actual = sha256.convert(bytes).toString();
    if (actual != sha) {
      fail(
        '$edition does not match its pinned SHA-256 ($actual). Delete '
        '$cacheDir/$edition.min.json and run again.',
      );
    }
    final json = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    editions[source] = (json['hadiths'] as List).cast<Map<String, dynamic>>();
  }

  final contents = citedHadithFile(editions, citedHadithNumbers(files));
  final out = File('content/$citedHadithPath');
  if (check) {
    if (!out.existsSync() || out.readAsStringSync() != contents) {
      fail('content/$citedHadithPath is out of date: run without --check.');
    }
    stdout.writeln('content/$citedHadithPath is up to date.');
    return;
  }
  out
    ..createSync(recursive: true)
    ..writeAsStringSync(contents);
  stdout.writeln('Wrote content/$citedHadithPath.');
}

Future<List<int>> _edition(String edition) async {
  final cached = File('$cacheDir/$edition.min.json');
  if (cached.existsSync()) return cached.readAsBytesSync();
  stdout.writeln('Downloading $edition…');
  final client = HttpClient();
  try {
    final request = await client.getUrl(
      Uri.parse(HadithDataset.editionUrl(edition)),
    );
    final response = await request.close();
    if (response.statusCode != 200) {
      fail('Download failed for $edition: HTTP ${response.statusCode}.');
    }
    final bytes = [for (final chunk in await response.toList()) ...chunk];
    cached
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
    return bytes;
  } finally {
    client.close();
  }
}
