import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/book_recommended_api_service.dart';
import 'package:book_wallert/services/fetch_bookId_from_isbn.dart';
import 'package:flutter/material.dart';

class BookRecommendController {
  final BookIdService _bookIdService = BookIdService();
  final RecommendDetailsService _recommendDetailsService =
      RecommendDetailsService();
  final BookForRecommendService _bookForRecommendService =
      BookForRecommendService();
  List<BookModel> recommendBooks = [];
  bool isLoading = false;
  int currentPage = 1;
  int userId;
  int? bookId;

  BookRecommendController(this.userId);

  // Fetch book ID using the book model
  Future<void> fetchBookId(BookModel book) async {
    try {
      bookId = await _bookIdService.fetchId(book);
    } catch (e) {
      throw Exception('Error fetching book ID: $e');
    }
  }

  // Fetch books to the followers
  Future<void> fetchBooks(Function(List<BookModel>) onDataFetched) async {
    if (isLoading) return;

    isLoading = true;

    try {
      List<BookModel> fetchedReviews =
          await _bookForRecommendService.fetchBooks(userId, currentPage);
      recommendBooks.addAll(fetchedReviews);
      currentPage++;
      onDataFetched(recommendBooks);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
    }
  }

  // Post recommendation details to followers
  Future<void> postRecommendation(int userId, int bookId) async {
    try {
      await _recommendDetailsService.postRecommendDetails(userId, bookId);
    } catch (e) {
      throw Exception('Error posting recommendation details: $e');
    }
  }

  Future<void> recommendBookToFollowers(
      BuildContext context, BookModel book) async {
    try {
      await fetchBookId(book);
      await postRecommendation(userId, bookId!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Book recommended to followers successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error recommending book: $e')),
      );
    }
  }
}
