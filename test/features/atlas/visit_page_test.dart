import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/core/location/location_service.dart';
import 'package:suhba/features/atlas/presentation/place_page.dart';
import 'package:suhba/features/atlas/presentation/visit_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';

import '../../helpers/app_harness.dart';

/// A position (or problem) fixed by the test; records settings requests.
class FakeLocation implements LocationService {
  FakeLocation(this.result);

  final LocationResult result;
  var settingsOpened = 0;

  @override
  Future<LocationResult> currentPosition() async => result;

  @override
  Future<void> openSettings() async => settingsOpened++;
}

void main() {
  Future<void> open(
    WidgetTester tester, {
    String location = AppRoutes.visitRoot,
    LocationResult result = const LocationUnavailable(LocationProblem.failed),
    FakeLocation? fake,
  }) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(600, 3000);
    addTearDown(tester.view.reset);
    await AppUnderTest(
      location: location,
      overrides: [
        locationServiceProvider.overrideWithValue(fake ?? FakeLocation(result)),
      ],
    ).pump(tester);
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

  testApp('ordered from the reader when they are in the city', (tester) async {
    // At the foot of Uhud.
    await open(tester, result: const LocationFound(24.499, 39.6125));
    await tester.tap(find.text('رتّبها بحسب قربها مني'));
    await tester.pumpAndSettle();
    expect(find.text('الأماكن مرتبة بحسب قربها منك.'), findsOneWidget);
    expect(find.textContaining('على أقل من كيلومتر منك'), findsOneWidget);
    expect(top(tester, 'أُحُد'), lessThan(top(tester, 'المسجد النبوي')));
  });

  testApp('a reader in Makkah is shown Makkah', (tester) async {
    await open(tester, result: const LocationFound(21.42, 39.83));
    await tester.tap(find.text('رتّبها بحسب قربها مني'));
    await tester.pumpAndSettle();
    expect(find.text('المسجد الحرام'), findsWidgets);
    expect(find.textContaining('كم منك'), findsWidgets);
  });

  testApp('a reader elsewhere keeps the order from the Haram', (tester) async {
    await open(tester, result: const LocationFound(30.04, 31.24)); // Cairo
    await tester.tap(find.text('رتّبها بحسب قربها مني'));
    await tester.pumpAndSettle();
    expect(
      find.text('لست في المدينة الآن، فالأماكن مرتبة بحسب قربها من الحرم.'),
      findsOneWidget,
    );
    expect(find.textContaining('كم منك'), findsNothing);
  });

  testApp('a permanent refusal points to the device settings', (tester) async {
    final fake = FakeLocation(
      const LocationUnavailable(LocationProblem.deniedForever),
    );
    await open(tester, fake: fake);
    await tester.tap(find.text('رتّبها بحسب قربها مني'));
    await tester.pumpAndSettle();
    expect(find.textContaining('من إعدادات الجهاز'), findsOneWidget);
    await tester.tap(find.text('فتح الإعدادات'));
    expect(fake.settingsOpened, 1);
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
