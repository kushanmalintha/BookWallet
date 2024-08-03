import 'package:book_wallert/controllers/review_for_book_controller.dart';
import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/locations_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class BookProfileScreenListView extends StatefulWidget {
  final String screenName;
  final BookModel book;

  const BookProfileScreenListView(
      {super.key, required this.screenName, required this.book});

  @override
  State<BookProfileScreenListView> createState() =>
      _BookProfileScreenListViewState();
}

class _BookProfileScreenListViewState extends State<BookProfileScreenListView> {
  final ReviewForBookController _reviewForBookController =
      ReviewForBookController();
  final ScrollController _scrollController = ScrollController();
  final List<String> screens = [
    'Reviews',
    'Locations',
    'Read online',
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
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

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_reviewForBookController.isloading) {
      _fetchMoreData();
    }
  }

  void _fetchMoreData() {
    _reviewForBookController.fetchPosts((updatedReviews) {
      setState(() {
        _reviewForBookController.reviews = updatedReviews;
      });
    });
  }

  Widget getScreen(String screenName, int index) {
    switch (screenName) {
      case 'Reviews':
        return ReviewCard(review: _reviewForBookController.reviews[index]);
      case 'Locations':
      case 'Read Online':
        return LocationsCard();
      default:
        return BookCard(book: dummyBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _reviewForBookController.reviews.length + 1,
      itemBuilder: (context, index) {
        if (index < _reviewForBookController.reviews.length) {
          return Column(
            children: [
              getScreen(widget.screenName, index),
              const SizedBox(height: 3),
            ],
          );
        } else {
          return buildProgressIndicator();
        }
      },
    );
  }
}
