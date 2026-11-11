import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/shared/content/domain/review.dart';

/// Development preview never bypasses release gating, even with a dart-define.
final shareCardPreviewProvider = Provider<bool>(
  (ref) => kDebugMode && const bool.fromEnvironment('SUHBA_SHARE_CARD_PREVIEW'),
);

bool canShareCard({
  required ContentChannel? channel,
  required bool provisional,
  required bool preview,
}) =>
    (kDebugMode && preview) ||
    (channel == ContentChannel.published && !provisional);

/// Keeps the original wording and only cuts after a complete sentence. A long
/// first sentence is not rewritten or cut into a potentially misleading quote.
String? cardExcerpt(String text, {int maxWords = 60}) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed.split(RegExp(r'\s+')).length <= maxWords) return trimmed;
  String? result;
  for (final end in RegExp(r'[.!?؟。](?:[»”"])?(?=\s|$)').allMatches(trimmed)) {
    final candidate = trimmed.substring(0, end.end);
    if (candidate.split(RegExp(r'\s+')).length > maxWords) break;
    result = candidate;
  }
  return result == null ? null : '$result …';
}
