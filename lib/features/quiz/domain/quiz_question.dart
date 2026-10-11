import 'package:siyar_sahaba/core/domain/historical_date.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/localized_text.dart';

/// Which questions a round draws from.
enum QuizMode {
  /// Everything.
  mixed,

  /// The Companions: names, kunyas, titles, family, deaths, stories.
  companions,

  /// The Seerah: events, dates, places and the order of chapters.
  seerah,
}

/// The kinds of question the generator writes. Each is phrased by the UI
/// from the question's [QuizQuestion.subject].
enum QuizKind {
  /// Who has this kunya? (subject: the kunya)
  companionByKunya(QuizMode.companions),

  /// What is this companion's kunya? (subject: the name)
  kunyaOfCompanion(QuizMode.companions),

  /// Who bore this title? (subject: the title)
  companionByTitle(QuizMode.companions),

  /// Where did this companion die? (subject: the name)
  deathPlace(QuizMode.companions),

  /// Which of these is one of a closed group? (subject: the group)
  memberOfCategory(QuizMode.companions),

  /// Who is this companion's father? (subject: the name)
  fatherOf(QuizMode.companions),

  /// Who is this companion's mother? (subject: the name)
  motherOf(QuizMode.companions),

  /// Which of these companions is in this story? (subject: the title)
  companionInStory(QuizMode.companions),

  /// In which year was this event? (subject: the event)
  eventYear(QuizMode.seerah),

  /// Which of these events came first? (no subject)
  earliestEvent(QuizMode.seerah),

  /// Where did this event take place? (subject: the event)
  eventPlace(QuizMode.seerah),

  /// Which of these events took place here? (subject: the place)
  eventAtPlace(QuizMode.seerah),

  /// Which of these Seerah chapters comes first? (no subject)
  earliestChapter(QuizMode.seerah);

  const QuizKind(this.mode);

  /// The themed mode this kind belongs to (it is also in [QuizMode.mixed]).
  final QuizMode mode;
}

/// One answer on offer.
sealed class QuizChoice {
  const QuizChoice();
}

/// A name, title, place or other text from the content.
final class TextChoice extends QuizChoice {
  const TextChoice(this.text);

  final LocalizedText text;

  @override
  bool operator ==(Object other) => other is TextChoice && other.text == text;

  @override
  int get hashCode => text.hashCode;
}

/// A year, shown with the app's date formatting.
final class DateChoice extends QuizChoice {
  const DateChoice(this.date);

  final HistoricalDate date;

  @override
  bool operator ==(Object other) => other is DateChoice && other.date == date;

  @override
  int get hashCode => date.hashCode;
}

/// A question with one correct answer among its [choices]. Everything in it
/// comes from the content: the generator never writes facts of its own.
class QuizQuestion {
  const QuizQuestion({
    required this.key,
    required this.kind,
    required this.choices,
    required this.correct,
    this.subject,
    this.subjectGender,
    this.explanation,
    this.route,
  });

  /// Stable across rounds (kind and subject ids), so recently asked
  /// questions can be avoided.
  final String key;
  final QuizKind kind;

  /// What the question is about, e.g. a name, an event or a group.
  final LocalizedText? subject;

  /// For agreement in the question ("توفي" or "توفيت"), when it is a person.
  final Gender? subjectGender;

  final List<QuizChoice> choices;

  /// Index of the correct answer in [choices].
  final int correct;

  /// A line from the content shown after answering.
  final LocalizedText? explanation;

  /// Where to read more about it.
  final String? route;

  QuizChoice get answer => choices[correct];
}
