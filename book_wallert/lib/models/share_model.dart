import 'package:book_wallert/models/review_model.dart';

class SharedReview {
  final int reviewId;
  final String sharerUsername;
  final ReviewModel review;
  final int sharedUserId;
  final String imagePath; // Adjust this based on your actual data structure

  SharedReview({
    required this.reviewId,
    required this.sharerUsername,
    required this.review,
    required this.sharedUserId,
    required this.imagePath,
  });

  factory SharedReview.fromJson(Map<String, dynamic> json) {
    return SharedReview(
      reviewId: json['reviewId'],
      sharerUsername: json['sharerUsername'],
      review: ReviewModel.fromJson(json['review']),
      sharedUserId: json['sharedUserId'],
      imagePath: json['imagePath'],
    );
  }
}
