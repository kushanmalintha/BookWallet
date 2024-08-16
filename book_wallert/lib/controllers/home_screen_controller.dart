import 'package:book_wallert/services/home_screen_api_service.dart';
import '../models/review_model.dart';
import '../models/book_model.dart';

class HomeScreenController {
  final HomeScreenService _homeScreenService = HomeScreenService();
  List<ReviewModel> reviews = [];
  List<BookModel> books = [];
  bool isLoading = false;
  int currentPage = 1;
  int userId;

  HomeScreenController(this.userId);

  Future<void> fetchHomeScreen(Function(List<ReviewModel>) onReviewsFetched,
      Function(List<BookModel>) onBooksFetched) async {
    if (isLoading) return;
    isLoading = true;
    try {
      List<dynamic> fetchedHomeScreen =
          await _homeScreenService.fetchHomeScreen(userId, currentPage);
      currentPage++;

      for (var item in fetchedHomeScreen) {
        // reviews
        if (item is ReviewModel) {
          reviews.add(item);
          // books
        } else if (item is BookModel) {
          books.add(item);
        }
      }

      onReviewsFetched(reviews);
      onBooksFetched(books);
    } catch (e) {
      print('Error fetching home screen: $e');
    } finally {
      isLoading = false;
    }
  }
}
