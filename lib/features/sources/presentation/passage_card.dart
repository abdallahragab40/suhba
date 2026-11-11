import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:suhba/core/design_system/tokens/fonts.dart';
import 'package:suhba/core/design_system/tokens/palette.dart';

/// Fixed logical canvas, rendered at 3× for 1080-pixel exports. No ambient text
/// scaling or device dimensions can alter the shared artifact.
enum PassageCardSize {
  square(360),
  story(640);

  const PassageCardSize(this.height);
  final double height;
}

class PassageCard extends StatelessWidget {
  const PassageCard({
    required this.excerpt,
    required this.origin,
    required this.sources,
    required this.footer,
    required this.size,
    required this.dark,
    this.notice,
    super.key,
  });
  final String excerpt, origin, sources, footer;
  final String? notice;
  final PassageCardSize size;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final ink = dark ? Palette.paper : Palette.ink;
    final gold = dark ? Palette.goldOnInk : Palette.goldText;
    Text text(
      String value,
      double font, {
      String family = AppFonts.cairo,
      Color? color,
    }) => Text(
      value,
      style: TextStyle(
        inherit: false,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        fontFamily: family,
        fontSize: font,
        height: 1.5,
        color: color ?? ink,
      ),
    );
    return MediaQuery.withNoTextScaling(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          width: 360,
          height: size.height,
          child: ColoredBox(
            color: dark ? Palette.ink : Palette.paperLowest,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  text('صُحبة', 26, family: AppFonts.amiri, color: gold),
                  const SizedBox(height: 4),
                  text(origin, 11),
                  const SizedBox(height: 12),
                  Container(height: 1, color: gold),
                  const SizedBox(height: 14),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        var font = 22.0;
                        while (font > 16) {
                          final painter = TextPainter(
                            text: TextSpan(
                              text: excerpt,
                              style: TextStyle(
                                fontFamily: AppFonts.amiri,
                                fontSize: font,
                                height: 1.5,
                              ),
                            ),
                            textDirection: TextDirection.rtl,
                          )..layout(maxWidth: constraints.maxWidth);
                          final fits = painter.height <= constraints.maxHeight;
                          painter.dispose();
                          if (fits) break;
                          font--;
                        }
                        return Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: text(excerpt, font, family: AppFonts.amiri),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  text(sources, 9),
                  if (notice != null) text(notice!, 10),
                  const SizedBox(height: 8),
                  text(footer, 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Keep references intact and require at least 16 logical pixels for the
/// excerpt. Oversized source lists use text sharing rather than tiny image text.
bool passageCardFits({
  required String excerpt,
  required String origin,
  required String sources,
  String? notice,
  required String footer,
}) {
  double height(String value, double font, String family) {
    final painter = TextPainter(
      text: TextSpan(
        text: value,
        style: TextStyle(fontFamily: family, fontSize: font, height: 1.5),
      ),
      textDirection: TextDirection.rtl,
    )..layout(maxWidth: 312);
    final result = painter.height;
    painter.dispose();
    return result;
  }

  return 48 +
          39 +
          4 +
          height(origin, 11, AppFonts.cairo) +
          12 +
          1 +
          14 +
          height(excerpt, 16, AppFonts.amiri) +
          14 +
          height(sources, 9, AppFonts.cairo) +
          (notice == null ? 0 : height(notice, 10, AppFonts.cairo)) +
          8 +
          height(footer, 10, AppFonts.cairo) <=
      360;
}

/// Captures only the card, never the preview controls or surrounding app.
Future<Uint8List> capturePassageCard(GlobalKey key) async {
  await WidgetsBinding.instance.endOfFrame;
  final boundary = key.currentContext?.findRenderObject();
  if (boundary is! RenderRepaintBoundary) throw StateError('Card unavailable');
  final image = await boundary.toImage(pixelRatio: 3);
  try {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) throw StateError('Card encoding failed');
    return data.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}
