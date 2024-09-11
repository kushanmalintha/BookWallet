import 'package:book_wallert/controllers/google_books_controller.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchListScreenBody extends StatefulWidget {
  String searchText;
  SearchListScreenBody({super.key, required this.searchText});

  @override
  State<SearchListScreenBody> createState() => _SearchListScreenBodyState();
}

class _SearchListScreenBodyState extends State<SearchListScreenBody> {
  final GoogleBooksController _booksController =
      GoogleBooksController(); // Instance of GoogleBooksController
  final ScrollController _scrollController =
      ScrollController(); // Controller for ListView scrolling

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // Attach scroll listener
    _booksController.fetchBooks(
        _onDataFetched,
        widget
            .searchText); // Initial data fetch when widget is first initialized
  }

  @override
  void dispose() {
    _scrollController.removeListener(
        _scrollListener); // Remove scroll listener to prevent memory leaks
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _booksController.fetchBooks(_onDataFetched,
          widget.searchText); // Fetch more data when scrolled to the bottom
    }
  }

  void _onDataFetched() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:
          _scrollController, // Attach scroll controller to ListView builder
      itemCount: _booksController.books.length +
          1, // Number of items in the list +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < _booksController.books.length) {
          return Column(
            children: [
              const SizedBox(height: 3), // Spacer between cards
              BookCard(
                  book: _booksController.books[index]), // Display review card
            ],
          );
        } else {
          return buildProgressIndicator(); // Display loading indicator when reaching end of list
        }
      },
    );
  }
}
