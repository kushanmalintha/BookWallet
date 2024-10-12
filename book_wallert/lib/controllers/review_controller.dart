import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:book_wallert/services/review_api_service.dart'; // Import ReviewService for fetching data
import '../models/review_model.dart'; // Import ReviewModel for data handling

class ReviewController {
  final GetReviewWithIdService _getReviewWithIdService =
      GetReviewWithIdService();
  List<ReviewModel> reviews = []; // List to store fetched reviews
  bool isLoading = false; // Flag to track loading state
  int currentPage = 1; // Track the current page of data being fetched

  Future<ReviewModel> fetchReview(int reviewId) async {
    try {
      ReviewModel fetchReview =
          await _getReviewWithIdService.fetchReview(reviewId);
      return fetchReview;
    } catch (e) {
      print('Error fetching reviews: $e');
    }
    return dummyReview;
  }
}














// class ReviewController {
//   final String apiUrl = 'http://${ip}:3000/api/posts';

//   Future<List<ReviewModel>> fetchUserReviews(int userId, int page) async {
//     final response = await http.get(Uri.parse('$apiUrl?user=$userId&page=$page'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((item) => ReviewModel.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load user reviews');
//     }
//   }
// }
