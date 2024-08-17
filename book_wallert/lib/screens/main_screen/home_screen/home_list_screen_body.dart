import 'dart:math';
import 'package:book_wallert/controllers/home_screen_controller.dart';
// import 'package:book_wallert/controllers/review_controller.dart'; // Import ReviewController for fetching data
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart'; // Import ReviewModel for data handling
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart'; // Import ReviewCard widget
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class HomeListScreenBody extends StatefulWidget {
  const HomeListScreenBody({super.key});

  @override
  State<HomeListScreenBody> createState() => _HomeListScreenBodyState();
}

class _HomeListScreenBodyState extends State<HomeListScreenBody> {
  // final ReviewController _reviewController =
  //     ReviewController(); // Instance of ReviewController
  final HomeScreenController _homeScreenController =
      HomeScreenController(globalUser!.userId);
  final ScrollController _scrollController =
      ScrollController(); // Controller for ListView scrolling

  List<dynamic> mixedContent = [];

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener); // Attach scroll listener
    // _reviewController.fetchPosts(
    //     _onDataFetched); // Initial data fetch when widget is first initialized
    _homeScreenController.fetchHomeScreen(_onReviewsFetched, _onBooksFetched);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(
    //    _scrollListener); // Remove scroll listener to prevent memory leaks
    // _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // _reviewController.fetchPosts(
  //     //     _onDataFetched); // Fetch more data when scrolled to the bottom
  //     _homeScreenController.fetchHomeScreen(_onReviewsFetched, _onBooksFetched);
  //   }
  // }

  void _onReviewsFetched(List<ReviewModel> updatedReviews) {
    setState(() {
      // _reviewController.reviews =
      //     updatedReviews; // Update state with the fetched reviews
      _homeScreenController.reviews = updatedReviews;
    });
  }

  void _onBooksFetched(List<BookModel> updatedBooks) {
    setState(() {
      // _reviewController.reviews =
      //     updatedReviews; // Update state with the fetched reviews
      _homeScreenController.books = updatedBooks;
      _combineAndShuffleContent();
    });
  }

  void _combineAndShuffleContent() {
    mixedContent = [];
    mixedContent.addAll(_homeScreenController.reviews);
    mixedContent.addAll(_homeScreenController.books);
    mixedContent.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:
          _scrollController, // Attach scroll controller to ListView builder
      itemCount: mixedContent.length +
          1, // Number of items in the list +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < mixedContent.length) {
          final item = mixedContent[index];
          if (item is ReviewModel) {
            return Column(
              children: [
                const SizedBox(height: 3),
                ReviewCard(review: item),
              ],
            );
          } else if (item is BookModel) {
            return Column(
              children: [
                const SizedBox(height: 3),
                BookCard(book: item),
              ],
            );
          }
        } else {
          return buildProgressIndicator(); // Loading indicator
        }
        return const SizedBox.shrink(); // Safety fallback
      },
    );
  }
}
