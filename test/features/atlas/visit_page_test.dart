import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/features/atlas/presentation/place_page.dart';
import 'package:suhba/features/atlas/presentation/visit_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';

import '../../helpers/app_harness.dart';

void main() {
  Future<void> open(
    WidgetTester tester, {
    String location = AppRoutes.visitRoot,
  }) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    await AppUnderTest(location: location).pump(tester);
  }

  /// The top of [text]'s first widget, to compare the order of rows.
  double top(WidgetTester tester, String text) =>
      tester.getTopLeft(find.text(text).last).dy;

  testApp("Madinah's sites, nearest the Prophet's Mosque first", (
    tester,
  ) async {
    await open(tester);
    expect(find.byType(VisitPage), findsOneWidget);
    expect(find.textContaining('وليست دليلًا للمناسك'), findsOneWidget);
    for (final name in ['المسجد النبوي', 'بقيع الغرقد', 'قباء', 'أُحُد']) {
      expect(find.text(name), findsWidgets, reason: name);
    }
    // Badr is far from Madinah.
    expect(find.text('بدر'), findsNothing);
    expect(top(tester, 'المسجد النبوي'), lessThan(top(tester, 'أُحُد')));
  });

  testApp('Makkah has its own sites', (tester) async {
    await open(tester);
    await tester.tap(find.text('مكة'));
    await tester.pumpAndSettle();
    expect(find.text('المسجد الحرام'), findsWidgets);
    expect(find.text('غار حراء'), findsWidgets);
    expect(find.text('بقيع الغرقد'), findsNothing);
  });

  testApp('the reader chooses the city; the app never asks where they are', (
    tester,
  ) async {
    await open(tester);
    expect(find.byIcon(Icons.my_location), findsNothing);
    expect(find.textContaining('موقعك'), findsNothing);
    expect(find.textContaining('كم منك'), findsNothing);
    await tester.tap(find.text('مكة'));
    await tester.pumpAndSettle();
    // Nearest the Haram first.
    expect(top(tester, 'المسجد الحرام'), lessThan(top(tester, 'غار حراء')));
  });

  testApp('opened from Explore', (tester) async {
    await open(tester, location: AppRoutes.explore);
    await tester.tap(find.text('الأماكن'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('أماكن المدينة ومكة'));
    await tester.pumpAndSettle();
    expect(find.byType(VisitPage), findsOneWidget);
  });

  testApp('a site names its Companions', (tester) async {
    await open(tester, location: AppRoutes.place('al-baqi'));
    expect(find.byType(PlacePage), findsOneWidget);
    expect(find.text('صحابة ارتبط ذكرهم بالمكان'), findsOneWidget);
    expect(find.text('عثمان بن عفان'), findsOneWidget);
    await tester.tap(find.text('عثمان بن عفان'));
    await tester.pumpAndSettle();
    expect(find.byType(CompanionProfilePage), findsOneWidget);
  });

  testApp("a site leads to its city's other sites", (tester) async {
    await open(tester, location: AppRoutes.place('al-baqi'));
    await tester.tap(find.text('أماكن أخرى في المدينة'));
    await tester.pumpAndSettle();
    expect(find.byType(VisitPage), findsOneWidget);
    expect(find.text('المسجد النبوي'), findsWidgets);
  });
}
