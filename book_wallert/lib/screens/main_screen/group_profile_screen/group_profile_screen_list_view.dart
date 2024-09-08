import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';

// A stateless widget that represents a list of books.
class GroupProfileScreenListView extends StatelessWidget {
  final String screenName;

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Reviews':
        return ReviewCard(
          review: dummyReview,
        );
      case 'Books':
        return BookCard(
          book: dummyBook,
        );
    }
    return BookCard(
      book: dummyBook,
    );
  }

  const GroupProfileScreenListView({super.key, required this.screenName, required int groupId});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Number of items in the list.
      itemCount: 10, // Change this to the number of books
      // Builder function for each list item.
      itemBuilder: (context, index) {
        return getScreen(screenName); //
      },
    );
  }
}
