import 'package:book_wallert/models/review.dart';
import 'package:book_wallert/models/review_model.dart';

class SharedReview {
  final int reviewId;
  final String sharerUsername;
  final ReviewModel review;
 // final String imagePath; // Adjust this based on your actual data structure

  SharedReview({
    required this.reviewId,
    required this.sharerUsername,
    required this.review,
   // required this.imagePath,
  });

  factory SharedReview.fromJson(Map<String, dynamic> json) {
    return SharedReview(
      reviewId: json['review_id'],
      sharerUsername: json['sharer_username'],
      review: ReviewModel.fromJson(json['review']),
      //imagePath: json['imagePath'], // Adjust this based on your actual data structure
    );
  }
}
