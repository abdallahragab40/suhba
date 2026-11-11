// Isolated native share-sheet smoke. Default: cancel. Optional probe mode reads
// only through a local offline fixture; no human recipient is selected.
// SUHBA_INTEGRATION_TEST=true flutter drive --keep-app-running --no-dds \
//   --driver=test_driver/share_card_driver.dart \
//   --target=integration_test/share_card_smoke_test.dart -d emulator-5554
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suhba/core/share/share_service.dart';
import 'package:suhba/features/sources/presentation/passage_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const probe = bool.fromEnvironment('SUHBA_SHARE_PROBE');
  testWidgets(
    probe
        ? 'offline receiving app reads the rendered card'
        : 'native chooser accepts the rendered card and cancellation returns',
    (tester) async {
      final card = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: RepaintBoundary(
                key: card,
                child: const PassageCard(
                  excerpt: 'نموذج لاختبار مشاركة الصورة، وليس رواية تاريخية.',
                  origin: 'اختبار محلي',
                  sources: 'نص تجريبي لا ينسب إلى مصدر تاريخي.',
                  footer: 'تطبيق صُحبة',
                  size: PassageCardSize.square,
                  dark: false,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final capture = capturePassageCard(card);
      await tester.pump();
      final bytes = await tester.runAsync(() => capture);
      expect(bytes, isNotNull);
      final nonce = DateTime.now().microsecondsSinceEpoch.toString();
      debugPrintSynchronously(
        probe
            ? 'SHARE_CARD_RECEIVER_OPEN_CHOOSER nonce=$nonce'
            : 'SHARE_CARD_SMOKE_OPEN_CHOOSER',
      );
      // The default driver cancels; probe mode selects only the offline QA app.
      await tester
          .runAsync(
            () => const PlatformShareService().shareFile(
              bytes!,
              fileName: probe ? 'suhba-smoke-$nonce.png' : 'suhba-smoke.png',
              mimeType: 'image/png',
              subject: probe
                  ? 'Suhba card smoke test $nonce'
                  : 'Suhba card smoke test',
              origin: const Rect.fromLTWH(0, 0, 100, 100),
            ),
          )
          .timeout(const Duration(seconds: 60));
      debugPrintSynchronously('SHARE_CARD_SMOKE_PASSED');
    },
  );
}
