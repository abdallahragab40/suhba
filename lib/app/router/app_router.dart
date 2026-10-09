import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/app_shell.dart';
import 'package:siyar_sahaba/app/router/not_found_page.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/app/router/transitions.dart';
import 'package:siyar_sahaba/core/design_system/gallery/design_gallery_page.dart';
import 'package:siyar_sahaba/features/biography/presentation/section_reader_page.dart';
import 'package:siyar_sahaba/features/bookmarks/presentation/saved_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/directory/directory_page.dart';
import 'package:siyar_sahaba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:siyar_sahaba/features/home/presentation/home_page.dart';
import 'package:siyar_sahaba/features/reading_progress/presentation/reading_history_page.dart';
import 'package:siyar_sahaba/features/search/presentation/search_page.dart';
import 'package:siyar_sahaba/features/settings/presentation/settings_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/about_page.dart';
import 'package:siyar_sahaba/features/sources/presentation/sources_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/chapter_page.dart';
import 'package:siyar_sahaba/features/stories/presentation/story_page.dart';
import 'package:siyar_sahaba/features/timeline/presentation/timeline_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = buildAppRouter();
  ref.onDispose(router.dispose);
  return router;
});

/// The app's routes: a four-tab shell in which each tab keeps its own
/// navigation stack.
GoRouter buildAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) => state.uri.path == '/' ? AppRoutes.home : null,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      // Full screen, above the tabs.
      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) =>
            fadeThroughPage(context, state, const SearchPage()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, _) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.companions,
                builder: (_, state) => DirectoryPage(
                  categoryId: state.uri.queryParameters['category'],
                ),
                routes: [
                  GoRoute(
                    path: ':cid',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      CompanionProfilePage(id: state.pathParameters['cid']!),
                    ),
                    routes: [
                      GoRoute(
                        path: 'sections/:sid',
                        pageBuilder: (context, state) => fadeThroughPage(
                          context,
                          state,
                          SectionReaderPage(
                            companionId: state.pathParameters['cid']!,
                            sectionId: state.pathParameters['sid']!,
                          ),
                        ),
                      ),
                      GoRoute(
                        path: 'timeline',
                        pageBuilder: (context, state) => fadeThroughPage(
                          context,
                          state,
                          TimelinePage(
                            companionId: state.pathParameters['cid']!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Stories open from profiles, so they live in this tab's stack.
              GoRoute(
                path: '${AppRoutes.stories}/:stid',
                pageBuilder: (context, state) => fadeThroughPage(
                  context,
                  state,
                  StoryPage(storyId: state.pathParameters['stid']!),
                ),
                routes: [
                  GoRoute(
                    path: 'chapters/:chid',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      ChapterPage(
                        storyId: state.pathParameters['stid']!,
                        chapterId: state.pathParameters['chid']!,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.saved,
                builder: (_, _) => const SavedPage(),
                routes: [
                  GoRoute(
                    path: 'history',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      const ReadingHistoryPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (_, _) => const SettingsPage(),
                routes: [
                  GoRoute(
                    path: 'about',
                    pageBuilder: (context, state) =>
                        fadeThroughPage(context, state, const AboutPage()),
                  ),
                  GoRoute(
                    path: 'sources',
                    pageBuilder: (context, state) =>
                        fadeThroughPage(context, state, const SourcesPage()),
                  ),
                  if (kDebugMode)
                    GoRoute(
                      path: 'design-gallery',
                      builder: (_, _) => const DesignGalleryPage(),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
