import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

/// Hands text to the platform share sheet. Nothing is sent by the app
/// itself; the reader chooses where it goes.
abstract interface class ShareService {
  /// [origin] anchors the share popover on tablets.
  Future<void> shareText(String text, {String? subject, Rect? origin});

  /// Offers [bytes] as a file named [fileName], e.g. to save or send.
  Future<void> shareFile(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
    String? subject,
    Rect? origin,
  });
}

class PlatformShareService implements ShareService {
  const PlatformShareService();

  @override
  Future<void> shareText(String text, {String? subject, Rect? origin}) =>
      SharePlus.instance.share(
        ShareParams(text: text, subject: subject, sharePositionOrigin: origin),
      );

  @override
  Future<void> shareFile(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
    String? subject,
    Rect? origin,
  }) => SharePlus.instance.share(
    ShareParams(
      files: [XFile.fromData(bytes, mimeType: mimeType, name: fileName)],
      fileNameOverrides: [fileName],
      subject: subject,
      sharePositionOrigin: origin,
    ),
  );
}

/// Overridden in tests to capture what would be shared.
final shareServiceProvider = Provider<ShareService>(
  (ref) => const PlatformShareService(),
);

/// The global rectangle of [context]'s render box, for [ShareService].
Rect? shareOriginOf(BuildContext context) {
  final box = context.findRenderObject();
  if (box is! RenderBox || !box.hasSize) return null;
  return box.localToGlobal(Offset.zero) & box.size;
}
