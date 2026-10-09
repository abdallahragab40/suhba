import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/not_found_page.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/features/atlas/presentation/event_page.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/saved_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/explore/presentation/explore_page.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:siyar_sahaba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:siyar_sahaba/features/settings/presentation/settings_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/about_page.dart';

import '../helpers/app_harness.dart';

void main() {
  group('AppRoutes', () {
    test('builds paths from IDs', () {
      expect(AppRoutes.companion('abu-bakr'), '/companions/abu-bakr');
      expect(
        AppRoutes.section('abu-bakr', 'abu-bakr.hijrah'),
        '/companions/abu-bakr/sections/abu-bakr.hijrah',
      );
      expect(AppRoutes.timeline('umar'), '/companions/umar/timeline');
      expect(
        AppRoutes.chapter('the-cave', 'the-cave.1'),
        '/stories/the-cave/chapters/the-cave.1',
      );
      expect(AppRoutes.source('isabah'), '/sources/isabah');
      expect(
        AppRoutes.seerahChapter('hijrah-to-madinah'),
        '/seerah/chapters/hijrah-to-madinah',
      );
      expect(AppRoutes.seerahTopic('mercy'), '/seerah/topics/mercy');
      expect(AppRoutes.event('badr'), '/events/badr');
      expect(AppRoutes.place('makkah'), '/places/makkah');
      expect(AppRoutes.visual('hijrah-route'), '/visuals/hijrah-route');
    });

    test('rejects IDs that are not ASCII slugs', () {
      for (final bad in ['أبو-بكر', 'Abu Bakr', 'a/b', '', '-x', 'x-']) {
        expect(
          () => AppRoutes.companion(bad),
          throwsArgumentError,
          reason: bad,
        );
      }
    });
  });

  group('router', () {
    Future<GoRouter> pumpRouter(
      WidgetTester tester, {
      String initialLocation = AppRoutes.home,
    }) async {
      final app = AppUnderTest(location: initialLocation);
      await app.pump(tester);
      return app.router;
    }

    Future<void> tapTab(WidgetTester tester, String label) async {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
    }

    testApp('/ redirects to Home', (tester) async {
      await pumpRouter(tester, initialLocation: '/');
      expect(find.byType(HomePage), findsOneWidget);
    });

    testApp('each destination shows its page', (tester) async {
      await pumpRouter(tester);
      await tapTab(tester, 'السيرة');
      expect(find.byType(SeerahHubPage), findsOneWidget);
      await tapTab(tester, 'الصحابة');
      expect(find.byType(DirectoryPage), findsOneWidget);
      await tapTab(tester, 'استكشف');
      expect(find.byType(ExplorePage), findsOneWidget);
      await tapTab(tester, 'المحفوظات');
      expect(find.byType(SavedPage), findsOneWidget);
      await tapTab(tester, 'الرئيسية');
      expect(find.byType(HomePage), findsOneWidget);
    });

    testApp('home is the first destination, on the right in RTL', (
      tester,
    ) async {
      await pumpRouter(tester);
      double x(String label) => tester
          .getCenter(
            find.descendant(
              of: find.byType(NavigationBar),
              matching: find.text(label),
            ),
          )
          .dx;
      expect(x('الرئيسية'), greaterThan(x('السيرة')));
      expect(x('السيرة'), greaterThan(x('الصحابة')));
      expect(x('الصحابة'), greaterThan(x('استكشف')));
      expect(x('استكشف'), greaterThan(x('المحفوظات')));
    });

    testApp('on a wide screen the destinations move to a rail', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(1100, 900);
      addTearDown(tester.view.reset);
      await pumpRouter(tester);
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testApp('settings opens from the app bar, above the destinations', (
      tester,
    ) async {
      await pumpRouter(tester);
      await tester.tap(find.byTooltip('الإعدادات'));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testApp('settings links keep working', (tester) async {
      final router = await pumpRouter(tester, initialLocation: AppRoutes.about);
      expect(find.byType(AboutPage), findsOneWidget);
      router.go(AppRoutes.settings);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testApp('a destination keeps its stack while another is used', (
      tester,
    ) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.companion('umar'));
      await tester.pumpAndSettle();
      expect(find.byType(CompanionProfilePage), findsOneWidget);

      await tapTab(tester, 'الرئيسية');
      expect(find.byType(HomePage), findsOneWidget);

      await tapTab(tester, 'الصحابة');
      expect(find.byType(CompanionProfilePage), findsOneWidget);
    });

    testApp('re-tapping the current destination returns it to its root', (
      tester,
    ) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.companion('umar'));
      await tester.pumpAndSettle();

      await tapTab(tester, 'الصحابة');
      expect(find.byType(DirectoryPage), findsOneWidget);
      expect(find.byType(CompanionProfilePage), findsNothing);
    });

    testApp('back pops within a destination, then goes Home, then exits', (
      tester,
    ) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.companion('umar'));
      await tester.pumpAndSettle();

      // Profile → directory root.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(DirectoryPage), findsOneWidget);

      // Directory root → Home.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      // Home root: nothing left to pop in the app.
      expect(router.canPop(), isFalse);
    });

    testApp('an event opened from a chapter returns to the chapter', (
      tester,
    ) async {
      final router = await pumpRouter(
        tester,
        initialLocation: AppRoutes.seerah,
      );
      unawaited(router.push(AppRoutes.seerahChapter('hijrah-to-madinah')));
      await tester.pumpAndSettle();
      unawaited(router.push(AppRoutes.event('hijrah')));
      await tester.pumpAndSettle();
      expect(find.byType(EventPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(SeerahChapterPage), findsOneWidget);
    });

    testApp('an unknown route shows the not-found page', (tester) async {
      await pumpRouter(tester, initialLocation: '/no/such/page');
      expect(find.byType(NotFoundPage), findsOneWidget);
      expect(find.text('الصفحة غير موجودة'), findsOneWidget);

      await tester.tap(find.text('العودة إلى الرئيسية'));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
