import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/review_for_book_controller.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class BookProfileScreenReviewListView extends StatefulWidget {
  final String screenName;
  final BookModel book;

  const BookProfileScreenReviewListView(
      {super.key, required this.screenName, required this.book});

  @override
  State<BookProfileScreenReviewListView> createState() =>
      _BookProfileScreenListViewState();
}

class _BookProfileScreenListViewState
    extends State<BookProfileScreenReviewListView> {
  final ReviewForBookController _reviewForBookController =
      ReviewForBookController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    try {
      await _reviewForBookController.fetchId(widget.book);
      _fetchInitialData();
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  void _fetchInitialData() {
    _reviewForBookController.fetchPosts((updatedReviews) {
      setState(() {
        _reviewForBookController.reviews = updatedReviews;
      });
    });
  }

  Widget getScreen(int index) {
    return ReviewCard(review: _reviewForBookController.reviews[index]);
  }

  @override
  Widget build(BuildContext context) {
    return _reviewForBookController.isloading
        ? Center(child: buildProgressIndicator())
        : _reviewForBookController.reviews.isEmpty
            ? const Center(
                child: Text('No reviews',
                    style: TextStyle(color: MyColors.textColor)))
            : ListView.builder(
                controller: _scrollController,
                itemCount: _reviewForBookController.reviews.length + 1,
                itemBuilder: (context, index) {
                  if (index < _reviewForBookController.reviews.length) {
                    return Column(
                      children: [
                        getScreen(index),
                        const SizedBox(height: 3),
                      ],
                    );
                  }
                  return null;
                },
              );
  }
}
