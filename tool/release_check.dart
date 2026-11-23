// Gates for a public release (plan task E03). Run both in the pipeline that
// produces the public artifact:
//
//   dart run tool/release_check.dart pre
//       Final identity, published content, and the complete first release.
//   dart run tool/release_check.dart artifact <app.aab|app.apk|Runner.ipa>
//       [--channel=published|draft]
//       The content inside the built artifact: channel, version, approvals
//       and file hashes. --channel=draft checks a preview build instead.
//       For an .aab/.apk also the merged manifest and signer against
//       config/android_release.yaml (versionCode floor, versionName =
//       pubspec, not debuggable, target SDK, permission allowlist, no
//       INTERNET, forbidden components; the .aab must carry the upload
//       certificate). Needs aapt2 (Android SDK build-tools, found through
//       ANDROID_HOME) and keytool (JDK); missing tools are failures.
//       [--min-version-code=N] overrides the floor;
//       [--skip-android-checks] skips them, loudly (never in the pipeline).
//
// Exits non-zero, listing every problem, if anything fails.
import 'dart:convert';
import 'dart:io';

import 'package:suhba/shared/content/data/dto/catalog_dto.dart';
import 'package:suhba/shared/content/domain/review.dart';

import 'src/app_identity.dart';
import 'src/cli_args.dart';
import 'src/content/content_files.dart';
import 'src/content/readiness.dart';
import 'src/content/schema_set.dart';
import 'src/release/android_artifact.dart';
import 'src/release/release_checks.dart';

void main(List<String> args) {
  requireProjectRoot();
  final positional = args.where((a) => !a.startsWith('--')).toList();
  switch (positional) {
    case ['pre']:
      _report(
        'Pre-build',
        preBuildProblems(
          identity: parseAppIdentity(
            File('config/app_identity.yaml').readAsStringSync(),
          ),
          readiness: contentReadiness(
            ContentFiles.fromDirectory(Directory('content')),
            SchemaSet.fromFile(SchemaSet.defaultPath),
          ),
        ),
      );
    case ['artifact', final path]:
      final channel = args.contains('--channel=draft')
          ? ContentChannel.draft
          : ContentChannel.published;
      final meta =
          jsonDecode(File('content/meta.json').readAsStringSync())
              as Map<String, dynamic>;
      final edition = EditionDto.fromJson(
        jsonDecode(File('content/release/edition.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      _report('Artifact ($path, ${channel.name})', [
        ...artifactProblems(
          bundled: _bundledContent(path),
          channel: channel,
          contentVersion: meta['contentVersion'] as String,
          requiredJourneyIds: edition.journeyIds,
        ),
        ..._androidProblems(path, args),
      ]);
    default:
      fail(
        'Usage: dart run tool/release_check.dart pre\n'
        '       dart run tool/release_check.dart artifact <file> '
        '[--channel=published|draft] [--min-version-code=N] '
        '[--skip-android-checks]',
      );
  }
}

void _report(String stage, List<String> problems) {
  if (problems.isEmpty) {
    stdout.writeln('$stage: all checks passed.');
    return;
  }
  problems.forEach(stderr.writeln);
  fail('\n$stage: ${problems.length} problems; no public artifact.');
}

/// Reads the bundled content out of an APK, AAB or IPA (all zip files).
Map<String, String> _bundledContent(String archive) {
  if (!File(archive).existsSync()) fail('No such file: $archive');
  final list = Process.runSync('unzip', ['-Z1', archive]);
  if (list.exitCode != 0) fail('Cannot read $archive: ${list.stderr}');
  final files = <String, String>{};
  for (final entry in LineSplitter.split(list.stdout as String)) {
    final match = contentEntry.firstMatch(entry);
    if (match == null) continue;
    final read = Process.runSync('unzip', [
      '-p',
      archive,
      entry,
    ], stdoutEncoding: utf8);
    if (read.exitCode != 0) fail('Cannot extract $entry: ${read.stderr}');
    files[match.group(1)!] = read.stdout as String;
  }
  return files;
}

/// Manifest and signer checks for an .aab or .apk; nothing for an .ipa.
List<String> _androidProblems(String archive, List<String> args) {
  final isBundle = archive.endsWith('.aab');
  if (!isBundle && !archive.endsWith('.apk')) return const [];
  if (args.contains('--skip-android-checks')) {
    stderr.writeln(
      'WARNING: --skip-android-checks: manifest and signer NOT checked.',
    );
    return const [];
  }
  var policy = parseAndroidReleasePolicy(
    File('config/android_release.yaml').readAsStringSync(),
  );
  final floor = option(args, 'min-version-code');
  if (floor != null) {
    policy = policy.withMinVersionCode(
      int.tryParse(floor) ?? fail('--min-version-code must be an integer.'),
    );
  }

  final aapt2 = _aapt2();
  if (aapt2 == null) {
    return [
      'Android: aapt2 not found (install SDK build-tools and set '
          'ANDROID_HOME); the manifest was not checked.',
    ];
  }
  final dump = _manifestDump(aapt2, archive, isBundle: isBundle);
  if (dump.error != null) return ['Android: ${dump.error}'];

  List<String>? signers;
  final problems = <String>[];
  if (isBundle) {
    final keytool = _keytool();
    if (keytool == null) {
      problems.add(
        'Android: keytool not found (install a JDK or set JAVA_HOME); '
        'the signer was not checked.',
      );
    } else {
      final r = Process.runSync(keytool, ['-printcert', '-jarfile', archive]);
      signers = parseSignerSha256('${r.stdout}');
    }
  } else {
    stdout.writeln(
      'Android: APK signer not checked (previews are debug-signed; the '
      'store artifact is the .aab).',
    );
  }
  final manifest = parseAapt2XmlTree(dump.output!);
  stdout.writeln(
    'Android: ${manifest.package} ${manifest.versionName} '
    '(${manifest.versionCode}), target SDK ${manifest.targetSdk}, '
    'permissions ${(manifest.permissions.toList()..sort()).join(', ')}',
  );
  return [
    ...problems,
    for (final p in androidArtifactProblems(
      manifest: manifest,
      policy: policy,
      expectedVersionName: pubspecVersionName(
        File('pubspec.yaml').readAsStringSync(),
      ),
      expectedPackage: parseAppIdentity(
        File('config/app_identity.yaml').readAsStringSync(),
      ).androidApplicationId,
      signers: signers,
    ))
      'Android: $p',
  ];
}

/// `aapt2 dump xmltree` of the merged manifest. aapt2 cannot open a bundle,
/// so its protobuf manifest is repacked alone into a zip that aapt2 reads.
({String? output, String? error}) _manifestDump(
  String aapt2,
  String archive, {
  required bool isBundle,
}) {
  var source = archive;
  Directory? temp;
  try {
    if (isBundle) {
      temp = Directory.systemTemp.createTempSync('suhba_manifest');
      final manifest = File('${temp.path}/AndroidManifest.xml');
      final read = Process.runSync('unzip', [
        '-p',
        archive,
        'base/manifest/AndroidManifest.xml',
      ], stdoutEncoding: null);
      if (read.exitCode != 0) {
        return (output: null, error: 'No base manifest in $archive.');
      }
      manifest.writeAsBytesSync(read.stdout as List<int>);
      final zip = Process.runSync('zip', [
        '-q',
        'manifest.zip',
        'AndroidManifest.xml',
      ], workingDirectory: temp.path);
      if (zip.exitCode != 0) {
        return (
          output: null,
          error: 'Cannot repack the manifest: ${zip.stderr}',
        );
      }
      source = '${temp.path}/manifest.zip';
    }
    final dump = Process.runSync(aapt2, [
      'dump',
      'xmltree',
      '--file',
      'AndroidManifest.xml',
      source,
    ]);
    if (dump.exitCode != 0) {
      return (
        output: null,
        error: 'aapt2 cannot read the manifest: ${dump.stderr}',
      );
    }
    return (output: dump.stdout as String, error: null);
  } finally {
    temp?.deleteSync(recursive: true);
  }
}

/// aapt2 on PATH, else from the newest SDK build-tools.
String? _aapt2() {
  if (_runs('aapt2', ['version'])) return 'aapt2';
  final env = Platform.environment;
  final home = env['HOME'] ?? '';
  for (final sdk in [
    env['ANDROID_HOME'],
    env['ANDROID_SDK_ROOT'],
    '$home/Library/Android/sdk',
    '$home/Android/Sdk',
  ]) {
    if (sdk == null || sdk.isEmpty) continue;
    final dir = Directory('$sdk/build-tools');
    if (!dir.existsSync()) continue;
    final versions =
        dir
            .listSync()
            .whereType<Directory>()
            .where((d) => File('${d.path}/aapt2').existsSync())
            .map((d) => d.path)
            .toList()
          ..sort(_compareVersionPaths);
    if (versions.isNotEmpty) return '${versions.last}/aapt2';
  }
  return null;
}

int _compareVersionPaths(String a, String b) {
  List<int> parts(String p) => [
    for (final s in p.split('/').last.split(RegExp(r'[.-]')))
      int.tryParse(s) ?? 0,
  ];
  final pa = parts(a), pb = parts(b);
  for (var i = 0; i < pa.length && i < pb.length; i++) {
    if (pa[i] != pb[i]) return pa[i].compareTo(pb[i]);
  }
  return pa.length.compareTo(pb.length);
}

/// A working keytool: JAVA_HOME, PATH (macOS has a stub without a JDK), or
/// Android Studio's bundled runtime.
String? _keytool() {
  final javaHome = Platform.environment['JAVA_HOME'];
  for (final candidate in [
    if (javaHome != null && javaHome.isNotEmpty) '$javaHome/bin/keytool',
    'keytool',
    '/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/keytool',
    '/opt/android-studio/jbr/bin/keytool',
  ]) {
    if (_runs(candidate, ['-help'])) return candidate;
  }
  return null;
}

bool _runs(String executable, List<String> args) {
  try {
    return Process.runSync(executable, args).exitCode == 0;
  } on ProcessException {
    return false;
  }
}
