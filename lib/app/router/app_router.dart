import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:suhba/app/router/app_shell.dart';
import 'package:suhba/app/router/not_found_page.dart';
import 'package:suhba/app/router/routes.dart';
import 'package:suhba/app/router/transitions.dart';
import 'package:suhba/features/atlas/presentation/event_page.dart';
import 'package:suhba/features/atlas/presentation/place_page.dart';
import 'package:suhba/features/atlas/presentation/visit_page.dart';
import 'package:suhba/features/atlas/presentation/visual_page.dart';
import 'package:suhba/features/biography/presentation/section_reader_page.dart';
import 'package:suhba/features/bookmarks/presentation/saved_page.dart';
import 'package:suhba/features/companions/presentation/directory/directory_page.dart';
import 'package:suhba/features/companions/presentation/profile/companion_profile_page.dart';
import 'package:suhba/features/explore/presentation/explore_page.dart';
import 'package:suhba/features/home/presentation/home_page.dart';
import 'package:suhba/features/quiz/domain/quiz_question.dart';
import 'package:suhba/features/quiz/presentation/quiz_home_page.dart';
import 'package:suhba/features/quiz/presentation/quiz_play_page.dart';
import 'package:suhba/features/reading_progress/presentation/reading_history_page.dart';
import 'package:suhba/features/relations/presentation/relations_page.dart';
import 'package:suhba/features/search/presentation/search_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_chapter_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_hub_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_timeline_page.dart';
import 'package:suhba/features/seerah/presentation/seerah_topic_page.dart';
import 'package:suhba/features/settings/presentation/settings_page.dart';
import 'package:suhba/features/sources/presentation/about_page.dart';
import 'package:suhba/features/sources/presentation/sources_page.dart';
import 'package:suhba/features/stories/presentation/chapter_page.dart';
import 'package:suhba/features/stories/presentation/story_page.dart';
import 'package:suhba/features/timeline/presentation/timeline_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = buildAppRouter();
  ref.onDispose(router.dispose);
  return router;
});

/// The app's routes: a five-destination shell (home, Seerah, companions,
/// explore, saved) in which each destination keeps its own stack, plus
/// full-screen routes above it (search, settings, and the shared event,
/// place and visual pages, so back always returns to where they were
/// opened from).
GoRouter buildAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) => state.uri.path == '/' ? AppRoutes.home : null,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      // Full screen, above the destinations.
      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) =>
            fadeThroughPage(context, state, const SearchPage()),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        pageBuilder: (context, state) =>
            fadeThroughPage(context, state, const QuizHomePage()),
        routes: [
          GoRoute(
            path: ':mode',
            pageBuilder: (context, state) => fadeThroughPage(
              context,
              state,
              QuizPlayPage(
                mode: QuizMode.values.firstWhere(
                  (m) => m.name == state.pathParameters['mode'],
                  orElse: () => QuizMode.mixed,
                ),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) =>
            fadeThroughPage(context, state, const SettingsPage()),
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
          GoRoute(
            path: 'history',
            pageBuilder: (context, state) =>
                fadeThroughPage(context, state, const ReadingHistoryPage()),
          ),
        ],
      ),
      GoRoute(
        path: '/events/:eid',
        pageBuilder: (context, state) => fadeThroughPage(
          context,
          state,
          EventPage(eventId: state.pathParameters['eid']!),
        ),
      ),
      GoRoute(
        path: '/places/:pid',
        pageBuilder: (context, state) => fadeThroughPage(
          context,
          state,
          PlacePage(placeId: state.pathParameters['pid']!),
        ),
      ),
      GoRoute(
        path: AppRoutes.visitRoot,
        pageBuilder: (context, state) => fadeThroughPage(
          context,
          state,
          VisitPage(city: state.uri.queryParameters['city']),
        ),
      ),
      GoRoute(
        path: AppRoutes.relationsRoot,
        pageBuilder: (context, state) => fadeThroughPage(
          context,
          state,
          RelationsPage(
            companionId: state.uri.queryParameters['companion'],
            personId: state.uri.queryParameters['person'],
          ),
        ),
      ),
      GoRoute(
        path: '/visuals/:vid',
        pageBuilder: (context, state) => fadeThroughPage(
          context,
          state,
          VisualPage(visualId: state.pathParameters['vid']!),
        ),
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
                path: AppRoutes.seerah,
                builder: (_, _) => const SeerahHubPage(),
                routes: [
                  GoRoute(
                    path: 'chapters/:chid',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      SeerahChapterPage(
                        chapterId: state.pathParameters['chid']!,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'topics/:tid',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      SeerahTopicPage(topicId: state.pathParameters['tid']!),
                    ),
                  ),
                  GoRoute(
                    path: 'timeline',
                    pageBuilder: (context, state) => fadeThroughPage(
                      context,
                      state,
                      const SeerahTimelinePage(),
                    ),
                  ),
                ],
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
              // Stories open from profiles, so they live in this stack.
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
                path: AppRoutes.explore,
                builder: (_, state) =>
                    ExplorePage(filter: state.uri.queryParameters['show']),
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
        ],
      ),
    ],
  );
}
