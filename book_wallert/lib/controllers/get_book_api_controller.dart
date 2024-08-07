import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/services/get_book_api_service.dart';
import '../models/book_model.dart';

class GetBookController {
  final GetBookService _getBookService = GetBookService();
  final int bookId;

  GetBookController(this.bookId);

  Future<BookModel> fetchBook() async {
    try {
      BookModel fetchedBook = await _getBookService.fetchBook(bookId);
      return fetchedBook;
    } catch (e) {
      print('Error fetching book: $e');
    }
    return dummyBook;
  }
}
