import 'package:flutter/material.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/tokens/typography.dart';

/// Every text role rendered with sample text, for the design gallery and the
/// golden tests.
///
/// The samples are neutral placeholder sentences, not biography content.
/// Qur'anic text is never typed by hand: the verse sample below is ordinary
/// Arabic, used only to show the Amiri Quran face.
class TypographySpecimen extends StatelessWidget {
  const TypographySpecimen({super.key});

  static const _uiSample =
      'نصٌّ تجريبيٌّ لمعاينة خطّ الواجهة، '
      'مع أرقامٍ عربية: ٠١٢٣٤٥٦٧٨٩.';
  static const _readingSample =
      'هذا نصٌّ تجريبيٌّ لمعاينة خطّ القراءة '
      'الطويلة بالتشكيل الكامل، وليس من محتوى السِّيَر؛ ويُستبدَل لاحقًا '
      'بالمحتوى المُراجَع مع مصادره.';
  static const _verseSample = '﴿ نصٌّ تجريبيٌّ لمعاينة خطّ الآيات فقط ﴾';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final styles = SahabaTextStyles.of(context);
    final colors = SahabaColors.of(context);

    final rows = <(String, TextStyle?, String)>[
      ('displaySmall · Amiri 700', text.displaySmall, 'سِيَر الصحابة'),
      ('headlineLarge · Cairo 900', text.headlineLarge, 'عشرة فصول'),
      ('headlineSmall · Cairo 800', text.headlineSmall, 'النشأة والإسلام'),
      ('titleLarge · Cairo 700', text.titleLarge, 'الهجرة إلى المدينة'),
      ('titleSmall · Cairo 600', text.titleSmall, 'الخط الزمني'),
      ('bodyLarge · Cairo 400', text.bodyLarge, _uiSample),
      ('bodySmall · Cairo 400', text.bodySmall, _uiSample),
      ('labelLarge · Cairo 600', text.labelLarge, 'المحفوظات · الإعدادات'),
      ('reading · Amiri 400', styles.reading, _readingSample),
      ('readingStrong · Amiri 700', styles.readingStrong, 'مُسَوَّدة'),
      ('quran · Amiri Quran', styles.quran, _verseSample),
      ('numeral · Cairo 900', styles.numeral, '١٣'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (label, style, sample) in rows)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: styles.kicker),
                const SizedBox(height: AppSpacing.xxs),
                Text(sample, style: style),
                const SizedBox(height: AppSpacing.sm),
                Divider(color: colors.line),
              ],
            ),
          ),
      ],
    );
  }
}
