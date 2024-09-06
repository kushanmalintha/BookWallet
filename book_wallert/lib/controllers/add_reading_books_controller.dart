import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/google_books_api_services.dart';
import 'package:flutter/material.dart';

class AddReadingBooksController {
  final GoogleBooksApiService _googleBooksService = GoogleBooksApiService();
  List<BookModel> books = []; // List to store fetched reviews
  bool isLoading = false; // Flag to track loading state
  int currentPage = 1; // Track the current page of data being fetched

  Future<void> fetchBooks(BuildContext context,
      {required String query, required int page}) async {
    if (isLoading) return; // Prevent concurrent requests
    isLoading = true; // Set loading state to true
    try {
      // Fetch reviews from the service
      books =
          await _googleBooksService.fetchBooks(page: currentPage, query: query);
    } catch (e) {
      print('Error fetching posts: $e'); // Print error if fetching fails
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Book Was Found!'),
          ),
        );
      }
    } finally {
      isLoading = false; // Set loading state to false after fetching completes
    }
  }
}
