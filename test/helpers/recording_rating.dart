import 'package:suhba/features/rating/presentation/rating_providers.dart';

/// Records rating requests instead of asking a store.
class RecordingRating implements RatingService {
  int reviews = 0;
  int listings = 0;

  @override
  Future<void> requestReview() async => reviews++;

  @override
  Future<void> openStoreListing() async => listings++;
}
