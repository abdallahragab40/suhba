import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:suhba/core/database/database_provider.dart';
import 'package:suhba/core/storage/settings_store.dart';
import 'package:suhba/features/journeys/domain/journey.dart';
import 'package:suhba/features/journeys/presentation/journey_providers.dart';
import 'package:suhba/features/rating/domain/rating_milestones.dart';
import 'package:suhba/features/reading_progress/presentation/progress_providers.dart';
import 'package:suhba/shared/content/providers.dart';

/// Rating the app in its store.
abstract interface class RatingService {
  /// Shows the store's own rating card over the app, if the store allows
  /// it now. The store decides; nothing is shown when its quota is spent.
  Future<void> requestReview();

  /// Opens the app's page in the store.
  Future<void> openStoreListing();
}

/// Google Play's in-app review. It talks to the Play Store app on the
/// device, so the app itself still needs no Internet access.
class PlayRatingService implements RatingService {
  const PlayRatingService();

  @override
  Future<void> requestReview() async {
    try {
      final review = InAppReview.instance;
      if (await review.isAvailable()) await review.requestReview();
    } on Object catch (error) {
      // No Play Store (a sideloaded or test install): nothing to show.
      debugPrint('In-app review unavailable: $error');
    }
  }

  /// Opens the app's Play page link, which the Play Store app takes (or the
  /// browser, on a device without it); the app itself fetches nothing.
  @override
  Future<void> openStoreListing() async {
    try {
      await InAppReview.instance.openStoreListing();
    } on Object catch (error) {
      debugPrint('Store page unavailable: $error');
    }
  }
}

final ratingServiceProvider = Provider<RatingService>(
  (ref) => const PlayRatingService(),
);

/// How long after an achievement the rating card is asked for, so the
/// reader first sees the page they finished. Zero in tests.
final ratingPromptDelayProvider = Provider<Duration>(
  (ref) => const Duration(milliseconds: 1500),
);

/// Every achievement in the reader's progress; null until it has loaded.
final reachedAchievementsProvider = Provider<Set<Achievement>?>((ref) {
  final completed = ref.watch(completedProgressProvider).value;
  final enrollments = ref.watch(journeyEnrollmentsProvider).value;
  final steps = ref.watch(journeyStepsProvider).value;
  final seerah = ref.watch(seerahIndexProvider);
  if (completed == null || enrollments == null || steps == null) return null;
  if (seerah.isLoading) return null;
  // The journeys' content is read only once the reader has started one.
  var journeys = const <Journey>[];
  if (enrollments.isNotEmpty) {
    final value = ref.watch(journeysProvider);
    if (value.isLoading) return null;
    journeys = value.value ?? const [];
  }
  return reachedAchievements(
    completed: completed,
    seerah: seerah.value,
    journeys: journeys,
    enrollments: enrollments,
    steps: steps,
  );
});

final ratingPrompterProvider = Provider<RatingPrompter>((ref) {
  final prompter = RatingPrompter(
    store: ref.watch(settingsStoreProvider),
    service: ref.watch(ratingServiceProvider),
    clock: ref.watch(clockProvider),
    delay: ref.watch(ratingPromptDelayProvider),
  );
  ref.onDispose(prompter.dispose);
  return prompter;
});

/// Applies [decideRatingPrompt] to each new look at the reader's progress,
/// keeps its state in settings and asks the store when it says so.
class RatingPrompter {
  RatingPrompter({
    required this.store,
    required this.service,
    required this.clock,
    required this.delay,
  });

  final SettingsStore store;
  final RatingService service;
  final DateTime Function() clock;
  final Duration delay;

  RatingState? _state;
  Timer? _pending;

  void onReached(Set<Achievement> reached) {
    final before = _state ??= _load();
    final decision = decideRatingPrompt(
      state: before,
      reached: reached,
      now: clock(),
    );
    final after = decision.state;
    _state = after;
    if (!setEquals(before.known, after.known)) {
      unawaited(
        store.setString(
          SettingsKeys.ratingKnown,
          jsonEncode(after.known!.toList()..sort()),
        ),
      );
    }
    if (decision.ask) {
      unawaited(
        store.setString(
          SettingsKeys.ratingAsked,
          jsonEncode([for (final k in after.asked) k.name]..sort()),
        ),
      );
      unawaited(
        store.setString(
          SettingsKeys.ratingLastAsked,
          after.lastAskedAt!.toIso8601String(),
        ),
      );
      if (delay == Duration.zero) {
        unawaited(service.requestReview());
      } else {
        _pending?.cancel();
        _pending = Timer(delay, () => unawaited(service.requestReview()));
      }
    }
  }

  void dispose() => _pending?.cancel();

  RatingState _load() {
    List<String>? list(String key) {
      final raw = store.getString(key);
      if (raw == null) return null;
      try {
        return (jsonDecode(raw) as List<Object?>).whereType<String>().toList();
      } on FormatException {
        return null;
      }
    }

    final asked = list(SettingsKeys.ratingAsked) ?? const [];
    final last = store.getString(SettingsKeys.ratingLastAsked);
    return RatingState(
      known: list(SettingsKeys.ratingKnown)?.toSet(),
      asked: {
        for (final name in asked)
          ...RatingMilestone.values.where((m) => m.name == name),
      },
      lastAskedAt: last == null ? null : DateTime.tryParse(last),
    );
  }
}
