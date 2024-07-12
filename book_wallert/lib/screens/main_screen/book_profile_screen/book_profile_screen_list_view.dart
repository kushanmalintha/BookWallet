import 'package:flutter/material.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card2.dart';

// A stateless widget that represents a list of books.
class BookProfileScreenListView extends StatelessWidget {
  final String screenName;
  final List<String> screens = [
    // name to screens
    'Reviews',
    'Locations',
    'Read online',
  ];

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Reviews':
        return ReviewCard();
      case 'Locations':
        return ReviewCard();
      case 'Read Online':
        return ReviewCard();
    }
    return const BookCard();
  }

  BookProfileScreenListView({super.key, required this.screenName});
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
