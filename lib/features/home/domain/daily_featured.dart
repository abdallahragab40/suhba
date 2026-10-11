import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/review.dart';

/// The companion featured on [date]: the same all day, a different one the
/// next day, cycling through everyone in order. Works offline (it depends
/// only on the local date).
///
/// On the published channel only approved companions can be featured; on
/// the draft channel everyone can (and is labelled as a draft).
CompanionSummary? featuredFor(
  DateTime date,
  List<CompanionSummary> companions, {
  required ContentChannel channel,
}) {
  final eligible = channel == ContentChannel.published
      ? companions.where((c) => c.review.isApproved).toList()
      : companions;
  if (eligible.isEmpty) return null;
  final day = DateTime.utc(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime.utc(1970)).inDays;
  return eligible[day % eligible.length];
}
