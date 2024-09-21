import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class BookRecomendedListview extends StatefulWidget {
  final int userId;

  const BookRecomendedListview({
    super.key,
    required this.userId,
  });

  @override
  State<BookRecomendedListview> createState() => _BookRecomendedListviewState();
}

class _BookRecomendedListviewState extends State<BookRecomendedListview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep alive when moving between list views

  late BookRecommendController _bookRecommendController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bookRecommendController = BookRecommendController(widget.userId);
    _fetchMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to fetch more data
  void _fetchMoreData() {
    _bookRecommendController.fetchBooks((updatedBooks) {
      setState(() {
        _bookRecommendController.recommendBooks = updatedBooks;
      });
    });
  }

  // Refresh handler (runs when the screen is pulled down to refresh)
  Future<void> _onRefresh() async {
    setState(() {
      _bookRecommendController.recommendBooks = [];
    });
    _bookRecommendController.fetchBooks((updatedBooks) {
      setState(() {
        _bookRecommendController.recommendBooks = updatedBooks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _bookRecommendController.isLoading
          ? Center(child: buildProgressIndicator())
          : _bookRecommendController.recommendBooks.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No books available',
                          style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: _bookRecommendController.recommendBooks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 3),
                        BookCard(
                          book: _bookRecommendController.recommendBooks[index],
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}
