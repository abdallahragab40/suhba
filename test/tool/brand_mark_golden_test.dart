@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/brand/brand_mark.dart';
import '../helpers/pump_app.dart';

/// Every layout of the brand mark side by side, on a mid-grey so the
/// transparent ones show their edges. If this changes, regenerate the
/// platform assets: `flutter test tool/brand/generate_brand_assets.dart`.
void main() {
  setUpAll(loadAppFonts);

  testWidgets('brand mark layouts', (tester) async {
    const tile = 160.0;
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = Size(tile * BrandMarkLayout.values.length, tile);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ColoredBox(
        color: const Color(0xFF808080),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            for (final layout in BrandMarkLayout.values)
              SizedBox.square(
                dimension: tile,
                child: CustomPaint(painter: _MarkPainter(layout)),
              ),
          ],
        ),
      ),
    );
    await expectLater(
      find.byType(ColoredBox),
      matchesGoldenFile('goldens/brand_mark.png'),
    );
  });
}

class _MarkPainter extends CustomPainter {
  _MarkPainter(this.layout);

  final BrandMarkLayout layout;

  @override
  void paint(Canvas canvas, Size size) => paintBrandMark(canvas, size, layout);

  @override
  bool shouldRepaint(_MarkPainter old) => old.layout != layout;
}
