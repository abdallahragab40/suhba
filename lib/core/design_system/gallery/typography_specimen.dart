import 'package:flutter/material.dart';
import 'package:suhba/core/design_system/tokens/spacing.dart';
import 'package:suhba/core/design_system/tokens/suhba_colors.dart';
import 'package:suhba/core/design_system/tokens/typography.dart';

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
    final styles = SuhbaTextStyles.of(context);
    final colors = SuhbaColors.of(context);

    final rows = <(String, TextStyle?, String)>[
      ('displaySmall · Amiri 700', text.displaySmall, 'سِيَر الصحابة'),
      ('headlineLarge · Plex 700', text.headlineLarge, 'عشرة فصول'),
      ('headlineSmall · Plex 600', text.headlineSmall, 'النشأة والإسلام'),
      ('titleLarge · Plex 600', text.titleLarge, 'الهجرة إلى المدينة ﷺ'),
      ('titleSmall · Plex 600', text.titleSmall, 'الخط الزمني'),
      ('bodyLarge · Plex 400', text.bodyLarge, _uiSample),
      ('bodySmall · Plex 400', text.bodySmall, _uiSample),
      ('labelLarge · Plex 600', text.labelLarge, 'مكتبتي، الإعدادات'),
      ('labelSmall · Plex 500', text.labelSmall, 'أنجزت ٣ من ١٤، ٩ مساءً'),
      ('reading · Amiri 400', styles.reading, _readingSample),
      ('readingStrong · Amiri 400, larger', styles.readingStrong, 'مُسَوَّدة'),
      ('readingHeading · Amiri 700', styles.readingHeading, 'النسب والمولد'),
      ('quran · Amiri Quran', styles.quran, _verseSample),
      ('numeral · Plex 700', styles.numeral, '١٣'),
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
