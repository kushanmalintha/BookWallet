import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/google_books_api_services.dart';

class GoogleBooksController {
  final GoogleBooksApiService _googleBooksService = GoogleBooksApiService();
  List<BookModel> books = []; // List to store fetched reviews
  bool isLoading = false; // Flag to track loading state
  int currentPage = 1; // Track the current page of data being fetched

  Future<void> fetchBooks(Function(List<BookModel>) onDataFetched, query) async {
    if (isLoading) return; // Prevent concurrent requests

    isLoading = true; // Set loading state to true

    try {
      // Fetch reviews from the service
      List<BookModel> fetchedReviews = await _googleBooksService.fetchBooks(
          page: currentPage, query: query);
      print(fetchedReviews);
      books.addAll(fetchedReviews); // Add fetched reviews to the list
      currentPage++; // Increment page number for the next fetch
      onDataFetched(books); // Notify the caller with updated reviews
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
  }
}
