import 'package:siyar_sahaba/core/result/result.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/domain/content_manifest.dart';
import 'package:siyar_sahaba/shared/content/domain/story.dart';

/// Read access to the content. Today it reads bundled assets; a remote
/// content-pack source can implement it later without UI changes.
abstract interface class ContentRepository {
  Future<Result<ContentManifest>> manifest();

  /// Summaries of every companion, in display order.
  Future<Result<List<CompanionSummary>>> companionIndex();

  /// Summaries of every story.
  Future<Result<List<StorySummary>>> storyIndex();

  /// A full companion, or `NotFoundFailure`.
  Future<Result<Companion>> companion(String id);

  /// A full story, or `NotFoundFailure`.
  Future<Result<Story>> story(String id);

  /// Categories in display order.
  Future<Result<List<CompanionCategory>>> categories();

  Future<Result<Map<String, HistoricalEvent>>> events();
  Future<Result<Map<String, SourceReference>>> sources();
  Future<Result<Map<String, Person>>> people();
}
