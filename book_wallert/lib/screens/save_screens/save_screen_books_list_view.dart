import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/saved_controller.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class SavedListViewBooks extends StatefulWidget {
  final int userId;

  SavedListViewBooks({
    super.key,
    required this.userId,
  });

  @override
  State<SavedListViewBooks> createState() => SavedListViewBooksState();
}

class SavedListViewBooksState extends State<SavedListViewBooks> {
  late SavedController _savedController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _savedController = SavedController(widget.userId);
    _fetchMoreData();

    // Add listener to scroll controller for infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMoreData() async {
    setState(() {
      _isLoading = true;
    });

    await _savedController.fetchBooks((updatedBooks) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _savedController.savedBooks.isEmpty
          ? Center(child: buildProgressIndicator())
          : _savedController.savedBooks.isEmpty
              ? const Center(
                  child: Text(
                    'No books',
                    style: TextStyle(color: MyColors.textColor),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _savedController.savedBooks.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _savedController.savedBooks.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          BookCard(book: _savedController.savedBooks[index]),
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator when more data is being fetched
                    }
                  },
                ),
    );
  }
}
