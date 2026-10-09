// Renders the app icon and launch-screen images for Android and iOS from
// the brand mark (tool/brand/brand_mark.dart). It runs under the Flutter
// test runner, which gives it a renderer and the bundled fonts:
//
//   flutter test tool/brand/generate_brand_assets.dart
//
// Commit the PNGs it writes. The XML and JSON that reference them are kept
// by hand (see docs/release.md).
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';

import '../../test/helpers/pump_app.dart';
import 'brand_mark.dart';
import 'png.dart';

const _androidRes = 'android/app/src/main/res';
const _iosAssets = 'ios/Runner/Assets.xcassets';

/// Android density buckets and their scale from mdpi.
const _densities = {
  'mdpi': 1.0,
  'hdpi': 1.5,
  'xhdpi': 2.0,
  'xxhdpi': 3.0,
  'xxxhdpi': 4.0,
};

void main() {
  testWidgets('generate brand assets', (tester) async {
    await tester.runAsync(() async {
      await loadAppFonts();

      for (final MapEntry(key: bucket, value: scale) in _densities.entries) {
        final dir = '$_androidRes/mipmap-$bucket';
        // Launchers before Android 8 use the whole bitmap.
        await _write(
          '$dir/ic_launcher.png',
          (48 * scale).round(),
          BrandMarkLayout.roundedSquare,
        );
        // Adaptive icon layers are 108 dp.
        await _write(
          '$dir/ic_launcher_foreground.png',
          (108 * scale).round(),
          BrandMarkLayout.adaptiveForeground,
        );
        await _write(
          '$dir/ic_launcher_monochrome.png',
          (108 * scale).round(),
          BrandMarkLayout.monochrome,
        );
        // Launch screen before Android 12: drawn at 120 dp.
        await _write(
          '$_androidRes/drawable-$bucket/splash_mark.png',
          (120 * scale).round(),
          BrandMarkLayout.disc,
        );
      }

      // iOS: every icon listed in the asset catalogue, opaque.
      const iconSet = '$_iosAssets/AppIcon.appiconset';
      final contents =
          jsonDecode(File('$iconSet/Contents.json').readAsStringSync())
              as Map<String, Object?>;
      for (final image
          in (contents['images']! as List<Object?>)
              .cast<Map<String, Object?>>()) {
        final points = double.parse(
          (image['size']! as String).split('x').first,
        );
        final scale = double.parse(
          (image['scale']! as String).replaceAll('x', ''),
        );
        await _write(
          '$iconSet/${image['filename']}',
          (points * scale).round(),
          BrandMarkLayout.square,
          alpha: false,
        );
      }

      // iOS launch screen: drawn at 120 pt.
      for (final (suffix, scale) in [('', 1), ('@2x', 2), ('@3x', 3)]) {
        await _write(
          '$_iosAssets/LaunchImage.imageset/LaunchImage$suffix.png',
          120 * scale,
          BrandMarkLayout.disc,
        );
      }
    });
  });
}

Future<void> _write(
  String path,
  int px,
  BrandMarkLayout layout, {
  bool alpha = true,
}) async {
  final recorder = ui.PictureRecorder();
  final size = ui.Size(px.toDouble(), px.toDouble());
  paintBrandMark(ui.Canvas(recorder), size, layout);
  final image = await recorder.endRecording().toImage(px, px);
  final data = await image.toByteData(
    format: ui.ImageByteFormat.rawStraightRgba,
  );
  image.dispose();
  File(path)
    ..parent.createSync(recursive: true)
    ..writeAsBytesSync(
      encodePng(data!.buffer.asUint8List(), px, px, alpha: alpha),
    );
  // ignore: avoid_print
  print('wrote $path ($px px)');
}
