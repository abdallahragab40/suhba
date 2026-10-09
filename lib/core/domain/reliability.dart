/// The standing of the underlying report in the sources.
///
/// This is not the review status of our own text: a report can be
/// [established] while our wording of it is still an unreviewed draft.
enum Reliability {
  /// ثابت: the Qur'an, a sahih or hasan hadith, or agreed by the historians.
  established,

  /// رواية تاريخية: reported in sira or history works; the chain is not
  /// authenticated or not assessed.
  reported,

  /// مختلف فيه: conflicting reports or scholarly disagreement.
  disputed,

  /// غير معروف: not reliably documented.
  unknown,
}
