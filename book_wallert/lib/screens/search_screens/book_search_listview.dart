import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/search_screen_controller.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookSearchListview extends StatefulWidget {
  String searchText;
  BookSearchListview({super.key, required this.searchText});

  @override
  State<BookSearchListview> createState() => _BookSearchListviewState();
}

class _BookSearchListviewState extends State<BookSearchListview>
    with AutomaticKeepAliveClientMixin {
  // AutomaticKeepAliveClientMixin added to make sure scroll view remains same when moving to other listviews in same screen
  @override
  bool get wantKeepAlive =>
      true; // Keep alive even when move to diffeerent listview

  final SearchScreenController _searchScreenController =
      SearchScreenController(); // Instance of SearchScreenController
  final ScrollController _scrollController =
      ScrollController(); // Controller for ListView scrolling

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // Attach scroll listener
    _searchScreenController.fetchBooks(
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
      _searchScreenController.fetchBooks(_onDataFetched,
          widget.searchText); // Fetch more data when scrolled to the bottom
    }
  }

  void _onDataFetched() {
    setState(() {});
  }

  // Refresh handler (this function runs on refresh sceen)
  Future<void> _onRefresh() async {
    setState(() {
      _searchScreenController.books = [];
      _searchScreenController.currentPage = 1;
    });

    await _searchScreenController.fetchBooks(_onDataFetched, widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // To keep alive
    return RefreshIndicator(
      // Add the ability to refresh screen when pull down
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller:
            _scrollController, // Attach scroll controller to ListView builder
        itemCount: _searchScreenController.books.length +
            1, // Number of items in the list +1 for loading indicator
        itemBuilder: (context, index) {
          if (index < _searchScreenController.books.length) {
            return Column(
              children: [
                const SizedBox(height: 3), // Spacer between cards
                BookCard(
                    book: _searchScreenController
                        .books[index]), // Display review card
              ],
            );
          } else {
            return buildProgressIndicator(); // Display loading indicator when reaching end of list
          }
        },
      ),
    );
  }
}
