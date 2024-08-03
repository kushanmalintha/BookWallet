import 'package:book_wallert/services/review_for_user_api_service.dart';
import '../models/review_model.dart';

class ReviewForUserController {
  final ReviewForUserService _reviewForUserService = ReviewForUserService();
  List<ReviewModel> reviews = [];
  bool isloading = false;
  int currentPage = 1;
  int? userId;

  Future<void> fetchPosts(Function(List<ReviewModel>) onDataFetched) async {
    if (isloading || userId == null) return;

    isloading = true;

    try {
      List<ReviewModel> fetchedReviews =
          await _reviewForUserService.fetchPosts(userId!, currentPage);
      reviews.addAll(fetchedReviews);
      currentPage++;
      onDataFetched(reviews);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isloading = false;
    }
  }
}
