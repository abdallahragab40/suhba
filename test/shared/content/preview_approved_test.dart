import 'package:flutter_test/flutter_test.dart';
import 'package:suhba/core/config/preview_approved.dart';
import 'package:suhba/shared/content/data/dto/catalog_dto.dart';
import 'package:suhba/shared/content/data/dto/common_dto.dart';
import 'package:suhba/shared/content/data/mappers/content_mappers.dart';
import 'package:suhba/shared/content/domain/review.dart';

/// The debug-only preview reads content as approved without changing it.
void main() {
  test('off unless asked for, and never in tests', () {
    expect(previewApproved, isFalse);
  });

  test('a draft reads as approved in preview, flags kept', () {
    const dto = ReviewDto(
      status: ReviewStatus.draft,
      editorialFlags: [EditorialFlag.sensitive],
    );
    expect(dto.toDomain().isApproved, isFalse);
    final preview = dto.toDomain(preview: true);
    expect(preview.isApproved, isTrue);
    expect(preview.editorialFlags, {EditorialFlag.sensitive});
  });

  test('a draft build reads as published in preview', () {
    final dto = ManifestDto.fromJson({
      'schemaVersion': 2,
      'contentVersion': '0.3.0',
      'channel': 'draft',
      'companionCount': 47,
      'storyCount': 20,
      'approvedCount': 0,
      'unapprovedCount': 10,
      'files': <String, String>{},
    });
    expect(dto.toDomain().isDraft, isTrue);
    final preview = dto.toDomain(preview: true);
    expect(preview.isDraft, isFalse);
    expect((preview.approvedCount, preview.unapprovedCount), (10, 0));
  });
}
