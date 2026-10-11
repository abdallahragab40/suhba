import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siyar_sahaba/core/storage/settings_store.dart';
import 'package:siyar_sahaba/features/quiz/domain/quiz_generator.dart';
import 'package:siyar_sahaba/features/quiz/domain/quiz_question.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// The content the quiz draws on: every companion and story in full, the
/// events, places, people, categories and Seerah chapters. Anything that
/// fails to load is left out (its questions are simply not asked).
final quizContentProvider = FutureProvider<QuizContent>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  final summaries = await ref.watch(companionIndexProvider.future);
  final storySummaries = await ref.watch(storyIndexProvider.future);
  final companions = await Future.wait(
    summaries.map((s) => repo.companion(s.id)),
  );
  final stories = await Future.wait(
    storySummaries.map((s) => repo.story(s.id)),
  );
  final events = await ref.watch(eventsProvider.future);
  final places = await ref.watch(placesProvider.future);
  final categories = await ref.watch(categoriesProvider.future);
  final seerah = await ref.watch(seerahIndexProvider.future);
  final people = (await repo.people()).valueOrNull ?? const {};
  return QuizContent(
    companions: [for (final r in companions) ?r.valueOrNull],
    stories: [for (final r in stories) ?r.valueOrNull],
    events: events.values.toList(),
    places: places,
    categories: categories,
    chapters: seerah.chapters,
    people: people,
  );
});

/// The randomness behind rounds; tests fix it.
final quizRandomProvider = Provider<Random>((ref) => Random());

/// Question keys asked lately, kept on the device so the next rounds ask
/// something else while the content allows.
final quizRecentProvider = NotifierProvider<QuizRecentController, Set<String>>(
  QuizRecentController.new,
);

class QuizRecentController extends Notifier<Set<String>> {
  static const keep = 80;

  @override
  Set<String> build() {
    final raw = ref
        .watch(settingsStoreProvider)
        .getString(SettingsKeys.quizRecent);
    if (raw == null) return const {};
    try {
      return {...(jsonDecode(raw) as List).cast<String>()};
    } on FormatException {
      return const {};
    }
  }

  Future<void> remember(Iterable<String> keys) async {
    final all = [...state, ...keys];
    final kept = all.skip(max(0, all.length - keep)).toList();
    state = {...kept};
    await ref
        .read(settingsStoreProvider)
        .setString(SettingsKeys.quizRecent, jsonEncode(kept));
  }
}

/// Best scores per mode (out of the round's length), kept on the device.
final quizBestProvider =
    NotifierProvider<QuizBestController, Map<QuizMode, int>>(
      QuizBestController.new,
    );

class QuizBestController extends Notifier<Map<QuizMode, int>> {
  @override
  Map<QuizMode, int> build() {
    final store = ref.watch(settingsStoreProvider);
    return {
      for (final mode in QuizMode.values)
        if (store.getDouble(SettingsKeys.quizBest(mode.name)) case final v?)
          mode: v.round(),
    };
  }

  /// Records [score] for [mode]; true when it beats the previous best.
  Future<bool> record(QuizMode mode, int score) async {
    final previous = state[mode];
    if (previous != null && score <= previous) return false;
    state = {...state, mode: score};
    await ref
        .read(settingsStoreProvider)
        .setDouble(SettingsKeys.quizBest(mode.name), score.toDouble());
    return previous != null || score > 0;
  }
}
