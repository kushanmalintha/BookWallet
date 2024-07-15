import 'package:book_wallert/services/review_api_service.dart'; // Import ReviewService for fetching data
import '../models/review_model.dart'; // Import ReviewModel for data handling

class ReviewController {
  final ReviewService _reviewService =
      ReviewService(); // Instance of ReviewService for fetching data
  List<ReviewModel> reviews = []; // List to store fetched reviews
  bool isLoading = false; // Flag to track loading state
  int currentPage = 1; // Track the current page of data being fetched

  Future<void> fetchPosts(Function(List<ReviewModel>) onDataFetched) async {
    if (isLoading) return; // Prevent concurrent requests

    isLoading = true; // Set loading state to true

    try {
      // Fetch reviews from the service
      List<ReviewModel> fetchedReviews =
          await _reviewService.fetchPosts(currentPage);
      reviews.addAll(fetchedReviews); // Add fetched reviews to the list
      currentPage++; // Increment page number for the next fetch
      onDataFetched(reviews); // Notify the caller with updated reviews
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
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
