import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/design_system/widgets/draft_badge.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/stories/presentation/chapter_page.dart';
import 'package:suhba/features/stories/presentation/story_page.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<AppUnderTest> open(WidgetTester tester, String path) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    final app = AppUnderTest(location: path);
    await app.pump(tester);
    return app;
  }

  testApp('overview: title, chapters in order, companions', (tester) async {
    await open(tester, '/stories/the-cave');
    expect(find.text('ثاني اثنين'), findsOneWidget);
    expect(find.byType(DraftBadge), findsOneWidget);
    expect(find.text('٣ دقائق قراءة'), findsOneWidget);
    final chapters = ['الخروج من مكة', 'في الغار', 'الطريق إلى المدينة'];
    final ys = [for (final c in chapters) tester.getTopLeft(find.text(c)).dy];
    expect([...ys]..sort(), ys);
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsOneWidget);
  });

  testApp('start reading, then walk the chapters to the end', (tester) async {
    final app = await open(tester, '/stories/the-cave');
    await tester.tap(find.text('ابدأ القراءة'));
    await tester.pumpAndSettle();
    expect(find.byType(ChapterPage), findsOneWidget);
    expect(find.text('الفصل ١ من ٣'), findsOneWidget);
    expect(find.text('الفصل السابق'), findsNothing);

    await tester.tap(find.text('في الغار'));
    await tester.pumpAndSettle();
    expect(app.location, '/stories/the-cave/chapters/the-cave.2');
    expect(find.text('قال الله تعالى — التوبة: ٤٠'), findsOneWidget);

    await tester.tap(find.text('الطريق إلى المدينة'));
    await tester.pumpAndSettle();
    expect(find.text('الفصل ٣ من ٣'), findsOneWidget);
    expect(find.text('انتهت القصة'), findsOneWidget);
    expect(find.text('الفصل التالي'), findsNothing);

    // The end card links to the companion.
    await tester.tap(find.text('أبو بكر الصديق رضي الله عنه'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
  });

  testApp('a two-companion story links both', (tester) async {
    await open(tester, '/stories/jam-al-quran/chapters/jam-al-quran.3');
    expect(find.text('أبو بكر الصديق رضي الله عنه'), findsOneWidget);
    expect(find.text('عمر بن الخطاب رضي الله عنه'), findsOneWidget);
  });

  testApp('the profile opens a story', (tester) async {
    final app = await open(tester, '/companions/abu-bakr');
    await tester.scrollUntilVisible(
      find.text('جمع القرآن في الصحف'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('جمع القرآن في الصحف'));
    await tester.pumpAndSettle();
    expect(find.byType(StoryPage), findsOneWidget);
    expect(app.location, '/stories/jam-al-quran');
  });

  testApp('unknown story and chapter are reported', (tester) async {
    await open(tester, '/stories/nope');
    expect(find.text('لم نجد هذه القصة.'), findsOneWidget);
  });

  testApp('an unknown chapter is reported', (tester) async {
    await open(tester, '/stories/the-cave/chapters/the-cave.9');
    expect(find.text('لم نجد هذه القصة.'), findsOneWidget);
  });
}
