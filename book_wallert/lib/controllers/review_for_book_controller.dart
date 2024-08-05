import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/fetch_bookId_from_ISBN.dart';
import 'package:book_wallert/services/review_for_book_api_service.dart';
import '../models/review_model.dart';

class ReviewForBookController {
  final ReviewForBookService _reviewForBookService = ReviewForBookService();
  final BookIdService _bookIdService = BookIdService();
  List<ReviewModel> reviews = [];
  bool isloading = false;
  int currentPage = 1;
  int? bookId;

  // Future<void> setBook(BookModel book) async {
  //   try {
  //     bookId = await _bookIdService.fetchId(book);
  //   } catch (e) {
  //     print('Error fetching book ID: $e');
  //   }
  // }

  Future<void> fetchId(BookModel book) async {
    try {
      bookId = await _bookIdService.fetchId(book);
    } catch (e) {
      print('Error fetching book ID: $e');
    }
  }

  Future<void> fetchPosts(Function(List<ReviewModel>) onDataFetched) async {
    if (isloading || bookId == null) return;

    isloading = true;

    try {
      List<ReviewModel> fetchedReviews =
          await _reviewForBookService.fetchPosts(bookId!, currentPage);
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
