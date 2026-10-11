import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/features/personal_data/domain/reading_data_archive.dart';

/// Lets the reader choose a file from the device; nothing is downloaded.
abstract interface class FileOpener {
  /// The chosen file's text, or null if the reader cancelled. Throws
  /// [FileTooLarge] above [ReadingDataArchive.maxBytes].
  Future<String?> openJsonText();
}

class FileTooLarge implements Exception {
  const FileTooLarge();
}

class SystemFileOpener implements FileOpener {
  const SystemFileOpener();

  @override
  Future<String?> openJsonText() async {
    final file = await openFile(
      acceptedTypeGroups: const [
        XTypeGroup(
          label: 'JSON',
          extensions: ['json'],
          // Many Android file managers label .json files generically.
          mimeTypes: [
            'application/json',
            'text/plain',
            'application/octet-stream',
          ],
          uniformTypeIdentifiers: ['public.json'],
        ),
      ],
    );
    if (file == null) return null;
    if (await file.length() > ReadingDataArchive.maxBytes) {
      throw const FileTooLarge();
    }
    return file.readAsString();
  }
}

/// Overridden in tests to supply a file's contents.
final fileOpenerProvider = Provider<FileOpener>(
  (ref) => const SystemFileOpener(),
);
