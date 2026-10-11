import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:suhba/core/share/share_service.dart';

/// Captures what the app would hand to the share sheet.
class RecordingShare implements ShareService {
  /// Shared texts with their subjects.
  final texts = <(String, String?)>[];

  /// Shared files: name, MIME type and contents as text.
  final files = <({String name, String mimeType, String content})>[];

  @override
  Future<void> shareText(String text, {String? subject, Rect? origin}) async {
    texts.add((text, subject));
  }

  @override
  Future<void> shareFile(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
    String? subject,
    Rect? origin,
  }) async {
    files.add((
      name: fileName,
      mimeType: mimeType,
      content: utf8.decode(bytes),
    ));
  }
}
