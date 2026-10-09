import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/not_found_page.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/gallery/design_gallery_page.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/saved_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';
import 'package:siyar_sahaba/features/settings/presentation/settings_page.dart';

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

    testApp('each tab shows its page', (tester) async {
      await pumpRouter(tester);
      await tapTab(tester, 'الصحابة');
      expect(find.byType(DirectoryPage), findsOneWidget);
      await tapTab(tester, 'المحفوظات');
      expect(find.byType(SavedPage), findsOneWidget);
      await tapTab(tester, 'الإعدادات');
      expect(find.byType(SettingsPage), findsOneWidget);
      await tapTab(tester, 'الرئيسية');
      expect(find.byType(HomePage), findsOneWidget);
    });

    testApp('home is the first tab, on the right in RTL', (tester) async {
      await pumpRouter(tester);
      final home = tester.getCenter(find.text('الرئيسية'));
      final settings = tester.getCenter(find.text('الإعدادات'));
      expect(home.dx, greaterThan(settings.dx));
    });

    testApp('a tab keeps its stack while another tab is used', (tester) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.designGallery);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(DesignGalleryPage), findsOneWidget);

      await tapTab(tester, 'الرئيسية');
      expect(find.byType(HomePage), findsOneWidget);

      await tester.tap(find.text('الإعدادات'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(DesignGalleryPage), findsOneWidget);
    });

    testApp('re-tapping the current tab returns it to its root', (
      tester,
    ) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.designGallery);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('الإعدادات'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(DesignGalleryPage), findsNothing);
    });

    testApp('back pops within a tab, then goes Home, then exits', (
      tester,
    ) async {
      final router = await pumpRouter(tester);
      router.go(AppRoutes.designGallery);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Gallery → Settings root.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);

      // Settings root → Home.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      // Home root: nothing left to pop in the app.
      expect(router.canPop(), isFalse);
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
