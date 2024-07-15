import 'package:book_wallert/controllers/review_controller.dart'; // Import ReviewController for fetching data
import 'package:book_wallert/models/review_model.dart'; // Import ReviewModel for data handling
import 'package:book_wallert/widgets/cards/review_card.dart'; // Import ReviewCard widget
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart'; // Import custom colors

class HomeListScreenBody extends StatefulWidget {
  const HomeListScreenBody({super.key});

  @override
  State<HomeListScreenBody> createState() => _HomeListScreenBodyState();
}

class _HomeListScreenBodyState extends State<HomeListScreenBody> {
  final ReviewController _reviewController =
      ReviewController(); // Instance of ReviewController
  final ScrollController _scrollController =
      ScrollController(); // Controller for ListView scrolling

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // Attach scroll listener
    _reviewController.fetchPosts(
        _onDataFetched); // Initial data fetch when widget is first initialized
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
      _reviewController.fetchPosts(
          _onDataFetched); // Fetch more data when scrolled to the bottom
    }
  }

  void _onDataFetched(List<ReviewModel> updatedReviews) {
    setState(() {
      _reviewController.reviews =
          updatedReviews; // Update state with the fetched reviews
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:
          _scrollController, // Attach scroll controller to ListView builder
      itemCount: _reviewController.reviews.length +
          1, // Number of items in the list +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < _reviewController.reviews.length) {
          return Column(
            children: [
              const SizedBox(height: 3), // Spacer between cards
              ReviewCard(
                  review:
                      _reviewController.reviews[index]), // Display review card
            ],
          );
        } else {
          return _buildProgressIndicator(); // Display loading indicator when reaching end of list
        }
      },
    );
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          color: MyColors
              .selectedItemColor, // Set color for the circular progress indicator
        ),
      ),
    );
  }
}
