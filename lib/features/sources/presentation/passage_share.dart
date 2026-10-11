import 'package:flutter/foundation.dart';

/// A passage the reader can share with its sources: the text exactly as
/// shown, and where it is from (e.g. "أبو بكر الصديق — الهجرة").
@immutable
class PassageShare {
  const PassageShare({required this.text, required this.origin});

  final String text;
  final String origin;
}

/// One source line of a shared passage, already in display form.
typedef ShareSourceLine = ({String title, String locator, String? grading});

/// The plain text that is shared: the passage in quotation marks, where it
/// is from, every source with its locator (and grading), the reliability
/// of the claim, a draft warning while the content is unreviewed, and the
/// app's name. Draft text never leaves the app without saying so.
String formatPassageShare({
  required PassageShare passage,
  required List<ShareSourceLine> sources,
  required String sourcesHeading,
  required String appLine,
  String? reliabilityLine,
  String? draftLine,
}) {
  final lines = <String>[
    '«${passage.text.trim()}»',
    '— ${passage.origin}',
    if (sources.isNotEmpty) ...[
      '',
      sourcesHeading,
      for (final s in sources)
        [
          '• ${s.title}',
          if (s.locator.isNotEmpty) '، ${s.locator}',
          if (s.grading case final g?) ' ($g)',
        ].join(),
    ],
    if (reliabilityLine != null || draftLine != null) '',
    ?reliabilityLine,
    ?draftLine,
    '',
    appLine,
  ];
  return lines.join('\n');
}
