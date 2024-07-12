import 'package:book_wallert/widgets/cards/book_cards/book_card_completed.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
//import 'package:book_wallert/cards/book_cards/book_card_recommended.dart';
//import 'package:book_wallert/cards/book_cards/book_card_trending.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card_wishlist.dart';

import 'package:book_wallert/widgets/cards/review_card2.dart';

// A stateless widget that represents a list of books.
class UserProfileListVeiw extends StatelessWidget {
  final String screenName;

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Reviews':
        return ReviewCard();
      case 'Reading':
        return const BookCard();
      case 'Wishlist':
        return const BookWishlistCard();
      case 'Completed':
        return const BookCompletedCard();
    }
    return const BookCard();
  }

  const UserProfileListVeiw({super.key, required this.screenName});
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
