import 'package:suhba/core/domain/reliability.dart';
import 'package:suhba/shared/content/domain/citation.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

/// A term a reader may not know (review E3), defined briefly and cited.
class GlossaryTerm {
  const GlossaryTerm({
    required this.id,
    required this.term,
    required this.forms,
    required this.definition,
    required this.reliability,
    required this.citations,
    required this.review,
  });

  final String id;
  final LocalizedText term;

  /// The spellings that link to it in passages, without tashkeel.
  final List<String> forms;
  final LocalizedText definition;
  final Reliability reliability;
  final List<Citation> citations;
  final ReviewInfo review;
}
