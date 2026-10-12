import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/domain/umm_al_qura.dart';

void main() {
  test('matches the published Umm al-Qura calendar', () {
    // 1 Muharram 1447, 1 Ramadan 1447 and the Day of Sacrifice 1447.
    expect(
      UmmAlQuraDate.fromGregorian(DateTime(2025, 6, 26)),
      const UmmAlQuraDate(1447, 1, 1),
    );
    expect(
      UmmAlQuraDate.fromGregorian(DateTime(2026, 2, 18)),
      const UmmAlQuraDate(1447, 9, 1),
    );
    expect(
      UmmAlQuraDate.fromGregorian(DateTime(2026, 5, 27)),
      const UmmAlQuraDate(1447, 12, 10),
    );
  });

  test('the time of day does not matter', () {
    expect(
      UmmAlQuraDate.fromGregorian(DateTime(2026, 10, 12, 23, 59)),
      UmmAlQuraDate.fromGregorian(DateTime(2026, 10, 12)),
    );
  });

  test('is null outside the calendar tables', () {
    expect(UmmAlQuraDate.fromGregorian(DateTime(1936, 12, 31)), isNull);
    expect(UmmAlQuraDate.fromGregorian(DateTime(2077)), isNull);
  });
}
