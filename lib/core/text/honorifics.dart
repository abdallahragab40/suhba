/// Who an honorific refers to.
enum HonorificSubject {
  /// One man: رضي الله عنه.
  man,

  /// One woman: رضي الله عنها.
  woman,

  /// Two people: رضي الله عنهما.
  pair,

  /// Three or more people: رضي الله عنهم.
  group,
}

/// The honorifics the app appends to names. Content never types them in
/// name fields (the content validator enforces this), so they are always
/// written in full and consistently.
abstract final class Honorifics {
  /// After the Prophet Muhammad's name.
  static const prophet = 'ﷺ';

  /// After the name of another prophet.
  static const alayhiSalam = 'عليه السلام';

  /// After a Companion's name.
  static String companion(HonorificSubject subject) => switch (subject) {
    HonorificSubject.man => 'رضي الله عنه',
    HonorificSubject.woman => 'رضي الله عنها',
    HonorificSubject.pair => 'رضي الله عنهما',
    HonorificSubject.group => 'رضي الله عنهم',
  };

  /// The form for [count] people of whom [allWomen] are women.
  static HonorificSubject subjectFor({
    required int count,
    bool allWomen = false,
  }) {
    assert(count > 0, 'count must be positive');
    if (count == 1) {
      return allWomen ? HonorificSubject.woman : HonorificSubject.man;
    }
    return count == 2 ? HonorificSubject.pair : HonorificSubject.group;
  }
}
