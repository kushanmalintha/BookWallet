import 'dart:math';
import 'package:book_wallert/controllers/home_screen_controller.dart';
// import 'package:book_wallert/controllers/review_controller.dart'; // Import ReviewController for fetching data
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart'; // Import ReviewModel for data handling
import 'package:book_wallert/models/share_model.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart'; // Import ReviewCard widget
import 'package:book_wallert/widgets/frames/shareby_frame.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class HomeListScreenBody extends StatefulWidget {
  const HomeListScreenBody({super.key});

  @override
  State<HomeListScreenBody> createState() => _HomeListScreenBodyState();
}

class _HomeListScreenBodyState extends State<HomeListScreenBody> {
  bool isLoaded = false;
  final HomeScreenController _homeScreenController =
      HomeScreenController(globalUser!.userId);
  final ScrollController _scrollController =
      ScrollController(); // Controller for ListView scrolling

  @override
  void initState() {
    super.initState();
    updateScreen();
  }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(
  //       _scrollListener); // Remove scroll listener to prevent memory leaks
  //   _scrollController.dispose(); // Dispose the scroll controller
  //   super.dispose();
  // }

  Future updateScreen() async {
    if (isLoaded == false) {
      _scrollController.addListener(_scrollListener); // Attach scroll listener
      await _homeScreenController.fetchHomeScreen(_upadateScreen1);
      isLoaded = true;
      setState(() {});
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _homeScreenController.fetchHomeScreen(_upadateScreen);
    }
  }


  void _upadateScreen() {
    setState(() {});
  }

  void _upadateScreen1() {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:
          _scrollController, // Attach scroll controller to ListView builder
      itemCount: _homeScreenController.mixedAllContent.length +
          1, // Number of items in the list +1 for loading indicator
      itemBuilder: (context, index) {
        if (index < _homeScreenController.mixedAllContent.length) {
          final item = _homeScreenController.mixedAllContent[index];
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
          } else if (item is SharedReview) {
            return Column(
              children: [
                const SizedBox(height: 3),
                SharedByCard(
                    userId: item.sharedUserId,
                    imagePath: item.imagePath,
                    sharedBy: [item.sharerUsername],
                    child: ReviewCard(review: item.review)),
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
