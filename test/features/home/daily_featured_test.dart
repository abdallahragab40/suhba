import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/features/home/domain/daily_featured.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';
import 'package:suhba/shared/content/domain/review.dart';

CompanionSummary _c(String id, {bool approved = false}) => CompanionSummary(
  id: id,
  gender: Gender.male,
  name: LocalizedText(ar: id),
  summary: const LocalizedText(ar: ''),
  review: ReviewInfo(
    status: approved ? ReviewStatus.approved : ReviewStatus.draft,
  ),
);

void main() {
  final ten = [for (var i = 0; i < 10; i++) _c('c$i')];

  test('the same all day', () {
    final morning = featuredFor(
      DateTime(2026, 10, 9, 0, 1),
      ten,
      channel: ContentChannel.draft,
    );
    final night = featuredFor(
      DateTime(2026, 10, 9, 23, 59),
      ten,
      channel: ContentChannel.draft,
    );
    expect(morning, night);
  });

  test('ten consecutive days feature all ten', () {
    final featured = {
      for (var d = 0; d < 10; d++)
        featuredFor(
          DateTime(2026, 10).add(Duration(days: d)),
          ten,
          channel: ContentChannel.draft,
        )!.id,
    };
    expect(featured, hasLength(10));
  });

  test('published channel features approved companions only', () {
    final mixed = [_c('a'), _c('b', approved: true), _c('c')];
    for (var d = 0; d < 5; d++) {
      expect(
        featuredFor(
          DateTime(2026).add(Duration(days: d)),
          mixed,
          channel: ContentChannel.published,
        )!.id,
        'b',
      );
    }
  });

  test('nothing to feature', () {
    expect(
      featuredFor(DateTime(2026), [_c('a')], channel: ContentChannel.published),
      isNull,
    );
    expect(
      featuredFor(DateTime(2026), const [], channel: ContentChannel.draft),
      isNull,
    );
  });
}
