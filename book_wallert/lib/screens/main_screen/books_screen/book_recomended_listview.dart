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

class _BookRecomendedListviewState extends State<BookRecomendedListview> {
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

  void _fetchMoreData() {
    _bookRecommendController.fetchBooks((updatedBooks) {
      setState(() {
        _bookRecommendController.recommendBooks = updatedBooks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _bookRecommendController.isLoading
        ? Center(child: buildProgressIndicator())
        : _bookRecommendController.recommendBooks.isEmpty
            ? const Center(
                child: Text('No books',
                    style: TextStyle(color: MyColors.textColor)))
            : ListView.builder(
                controller: _scrollController,
                itemCount: _bookRecommendController.recommendBooks.length + 1,
                itemBuilder: (context, index) {
                  if (index < _bookRecommendController.recommendBooks.length) {
                    return Column(
                      children: [
                        const SizedBox(height: 3),
                        BookCard(
                            book:
                                _bookRecommendController.recommendBooks[index]),
                      ],
                    );
                  }
                  return null;
                },
              );
  }
}
