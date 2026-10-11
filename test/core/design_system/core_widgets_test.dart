import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/theme/app_theme.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/widgets/empty_state.dart';
import 'package:suhba/core/design_system/widgets/error_view.dart';
import 'package:suhba/core/design_system/widgets/geometric_pattern.dart';
import 'package:suhba/core/design_system/widgets/loading_skeleton.dart';
import 'package:suhba/core/design_system/widgets/outlined_numeral.dart';
import 'package:suhba/core/design_system/widgets/reliability_badge.dart';
import 'package:suhba/core/design_system/widgets/section_header.dart';
import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/core/format/digits.dart';
import 'package:suhba/core/result/failure.dart';

import '../../helpers/pump_app.dart';
import 'contrast_test.dart' show contrast;

void main() {
  Future<void> pump(
    WidgetTester tester,
    Widget child, {
    DigitStyle digitStyle = DigitStyle.arabicIndic,
    bool disableAnimations = true,
  }) async {
    await tester.pumpWidget(
      testHarness(
        theme: AppTheme.light,
        digitStyle: digitStyle,
        disableAnimations: disableAnimations,
        child: Scaffold(body: child),
      ),
    );
    await tester.pump();
  }

  group('SectionHeader', () {
    testWidgets('shows a padded index in the digit style', (tester) async {
      await pump(tester, const SectionHeader(index: 1, title: 'عنوان'));
      expect(find.text('٠١'), findsOneWidget);

      await pump(
        tester,
        const SectionHeader(index: 1, title: 'عنوان'),
        digitStyle: DigitStyle.western,
      );
      expect(find.text('01'), findsOneWidget);
    });

    testWidgets('the title is a header; the index is not read out', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await pump(
        tester,
        const SectionHeader(index: 3, kicker: 'السيرة', title: 'عنوان'),
      );
      expect(
        tester.getSemantics(find.text('عنوان')),
        matchesSemantics(label: 'عنوان', isHeader: true),
      );
      expect(find.bySemanticsLabel('٠٣'), findsNothing);
      handle.dispose();
    });
  });

  group('ReliabilityBadge', () {
    const labels = {
      Reliability.established: 'ثابت',
      Reliability.reported: 'رواية تاريخية',
      Reliability.disputed: 'مختلف فيه',
      Reliability.unknown: 'غير معروف',
    };

    for (final MapEntry(key: level, value: label) in labels.entries) {
      testWidgets('${level.name}: icon, text and screen-reader label', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await pump(tester, ReliabilityBadge(level));
        expect(find.text(label), findsOneWidget);
        expect(find.byType(Icon), findsOneWidget);
        expect(find.bySemanticsLabel('درجة الثبوت: $label'), findsOneWidget);
        handle.dispose();
      });
    }

    testWidgets('provisional badges say so to sighted and screen-reader '
        'users', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(
        tester,
        const ReliabilityBadge(Reliability.established, provisional: true),
      );
      expect(
        find.bySemanticsLabel(
          'درجة الثبوت: ثابت، تصنيف مبدئي بانتظار المراجعة',
        ),
        findsOneWidget,
      );
      expect(find.byType(Tooltip), findsOneWidget);
      handle.dispose();
    });

    testWidgets('provisional badges have no fill; others are tinted', (
      tester,
    ) async {
      BoxDecoration decorationOf() =>
          tester
                  .widget<Container>(
                    find.descendant(
                      of: find.byType(ReliabilityBadge),
                      matching: find.byType(Container),
                    ),
                  )
                  .decoration!
              as BoxDecoration;

      await pump(tester, const ReliabilityBadge(Reliability.disputed));
      expect(decorationOf().color, isNotNull);
      await pump(
        tester,
        const ReliabilityBadge(Reliability.disputed, provisional: true),
      );
      expect(decorationOf().color, isNull);
    });

    for (final (name, theme) in [
      ('light', AppTheme.light),
      ('dark', AppTheme.dark),
    ]) {
      test('$name: badge text meets 4.5:1 on its tint over every surface', () {
        final colors = theme.extension<SuhbaColors>()!;
        final surfaces = [theme.colorScheme.surface, colors.surfaceAlt];
        for (final level in Reliability.values) {
          final color = ReliabilityBadge.colorFor(level, colors);
          for (final surface in surfaces) {
            final tint = Color.alphaBlend(
              color.withValues(alpha: ReliabilityBadge.tintAlpha),
              surface,
            );
            expect(
              contrast(color, tint),
              greaterThanOrEqualTo(4.5),
              reason: '${level.name} on $surface',
            );
          }
        }
      });
    }
  });

  testWidgets('OutlinedNumeral is decorative and ignores text scale', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, const OutlinedNumeral(13));
    expect(find.text('١٣'), findsOneWidget);
    expect(find.bySemanticsLabel('١٣'), findsNothing);
    final text = tester.widget<Text>(find.text('١٣'));
    expect(text.textScaler, TextScaler.noScaling);
    handle.dispose();
  });

  testWidgets('GeometricPattern paints and adds no semantics', (tester) async {
    await pump(
      tester,
      const SizedBox(width: 200, height: 200, child: GeometricPattern()),
    );
    final paint = tester.widget<CustomPaint>(
      find.descendant(
        of: find.byType(GeometricPattern),
        matching: find.byType(CustomPaint),
      ),
    );
    expect(paint.painter, isNotNull);
    expect(paint.painter!.semanticsBuilder, isNull);
    expect(
      find.descendant(
        of: find.byType(GeometricPattern),
        matching: find.byType(Semantics),
      ),
      findsNothing,
    );
  });

  group('EmptyState and ErrorView', () {
    testWidgets('EmptyState shows title, message and action', (tester) async {
      await pump(
        tester,
        EmptyState(
          icon: Icons.bookmark_border,
          title: 'لا شيء هنا',
          message: 'رسالة',
          action: TextButton(onPressed: () {}, child: const Text('إجراء')),
        ),
      );
      expect(find.text('لا شيء هنا'), findsOneWidget);
      expect(find.text('رسالة'), findsOneWidget);
      expect(find.text('إجراء'), findsOneWidget);
    });

    testWidgets('ErrorView retries', (tester) async {
      var retries = 0;
      await pump(tester, ErrorView(onRetry: () => retries++));
      expect(find.text('تعذّر عرض هذا المحتوى'), findsOneWidget);
      await tester.tap(find.text('إعادة المحاولة'));
      expect(retries, 1);
    });

    testWidgets('ErrorView without onRetry has no button', (tester) async {
      await pump(tester, const ErrorView());
      expect(find.text('إعادة المحاولة'), findsNothing);
    });

    testWidgets('ErrorView asks for an app update for newer content', (
      tester,
    ) async {
      await pump(
        tester,
        ErrorView(
          onRetry: () {},
          error: const UnsupportedFormatFailure('v2', found: 2, supported: {1}),
        ),
      );
      expect(find.textContaining('حدّث التطبيق'), findsOneWidget);
      expect(find.text('إعادة المحاولة'), findsNothing, reason: 'cannot help');
    });
  });

  group('LoadingSkeleton', () {
    testWidgets('announces loading', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester, const LoadingSkeleton());
      expect(find.bySemanticsLabel('جارٍ التحميل'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('is still when animations are disabled', (tester) async {
      await pump(tester, const LoadingSkeleton());
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('pulses when animations are enabled', (tester) async {
      await pump(tester, const LoadingSkeleton(), disableAnimations: false);
      expect(tester.hasRunningAnimations, isTrue);
    });
  });

  testWidgets('core widgets meet tap-target and labelling guidelines', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(
      tester,
      ListView(
        children: [
          const SectionHeader(index: 1, kicker: 'السيرة', title: 'عنوان'),
          const ReliabilityBadge(Reliability.established),
          const SizedBox(height: 300, child: ErrorView()),
          SizedBox(height: 300, child: ErrorView(onRetry: () {})),
        ],
      ),
    );
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
