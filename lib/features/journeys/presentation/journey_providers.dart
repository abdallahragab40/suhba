import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/features/journeys/data/drift_journey_repository.dart';
import 'package:suhba/features/journeys/data/journey_actions.dart';
import 'package:suhba/features/journeys/data/journey_reconciliation.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/domain/journey_progress.dart';
import 'package:suhba/features/journeys/domain/journey_runtime.dart';
import 'package:suhba/features/quiz/presentation/quiz_providers.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/features/review/presentation/review_providers.dart';
import 'package:suhba/shared/content/providers.dart';

final journeyRepositoryProvider = Provider<DriftJourneyRepository>(
  (ref) => DriftJourneyRepository(ref.watch(appDatabaseProvider)),
);
final journeyEnrollmentsProvider = StreamProvider<List<JourneyEnrollment>>(
  (ref) => ref.watch(journeyRepositoryProvider).watchEnrollments(),
);
final journeyStepsProvider = StreamProvider<List<JourneyStepProgress>>(
  (ref) => ref.watch(journeyRepositoryProvider).watchSteps(),
);
final journeysProvider = FutureProvider<List<Journey>>(
  (ref) async =>
      (await ref.watch(contentRepositoryProvider).journeys()).getOrThrow(),
);
final journeyRuntimeProvider = FutureProvider.autoDispose
    .family<JourneyRuntime, String>((ref, id) async {
      final content = ref.watch(contentRepositoryProvider);
      final repository = ref.watch(journeyRepositoryProvider);
      final clock = ref.watch(clockProvider);
      final quiz = await ref.watch(quizContentProvider.future);
      final journey = (await content.journey(id)).getOrThrow();
      await reconcileJourneys(
        content: content,
        journeys: repository,
        clock: clock,
      );
      return resolveJourney(content, journey, quiz);
    });
final journeyActionsProvider = Provider<JourneyActions>(
  (ref) => JourneyActions(
    db: ref.watch(appDatabaseProvider),
    journeys: ref.watch(journeyRepositoryProvider),
    reading: ref.watch(readingProgressRepositoryProvider),
    reviews: ref.watch(reviewRepositoryProvider),
    clock: ref.watch(clockProvider),
  ),
);
