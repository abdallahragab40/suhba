/// Every route path in the app. Build locations with these helpers rather
/// than string literals.
///
/// Path parameters are stable ASCII data IDs (slugs), never display text, so
/// links do not depend on the digit style or the locale.
abstract final class AppRoutes {
  // Tab roots.
  static const home = '/home';
  static const companions = '/companions';
  static const saved = '/saved';

  /// Finished reading, under Saved.
  static const readingHistory = '$saved/history';
  static const settings = '/settings';

  // Companions (M2–M3).

  /// The directory, optionally filtered to one category.
  static String companionsInCategory(String? categoryId) => categoryId == null
      ? companions
      : Uri(
          path: companions,
          queryParameters: {'category': _id(categoryId)},
        ).toString();

  static String companion(String id) => '$companions/${_id(id)}';
  static String section(String companionId, String sectionId) =>
      '${companion(companionId)}/sections/${_id(sectionId)}';
  static String timeline(String companionId) =>
      '${companion(companionId)}/timeline';

  // Stories (M3).
  static const stories = '/stories';
  static String story(String id) => '$stories/${_id(id)}';
  static String chapter(String storyId, String chapterId) =>
      '${story(storyId)}/chapters/${_id(chapterId)}';

  // Sources, search and settings pages (M2–M4).
  static String source(String id) => '/sources/${_id(id)}';
  static const search = '/search';
  static const about = '$settings/about';
  static const sourcesDirectory = '$settings/sources';

  /// Developer-only design system gallery (debug builds).
  static const designGallery = '$settings/design-gallery';

  static final _slug = RegExp(r'^[a-z0-9]+(?:[-.][a-z0-9]+)*$');

  static String _id(String id) {
    if (!_slug.hasMatch(id)) {
      throw ArgumentError.value(id, 'id', 'Route IDs must be ASCII slugs');
    }
    return id;
  }
}
