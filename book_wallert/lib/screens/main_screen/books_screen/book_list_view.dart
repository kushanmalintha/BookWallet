import 'package:flutter/material.dart';
import 'package:book_wallert/cards/book_cards/book_card.dart';
import 'package:book_wallert/cards/book_cards/book_card_recommended.dart';
import 'package:book_wallert/cards/book_cards/book_card_trending.dart';
import 'package:book_wallert/cards/book_cards/book_card_wishlist.dart';
import 'package:book_wallert/cards/book_cards/book_card_completed.dart';

// A stateless widget that represents a list of books.
class BookListView extends StatelessWidget {
  final String screenName;
  final List<String> screens = [
    // name to screens
    'Recommended',
    'Trending',
    'Wishlist',
    'Completed',
  ];

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Recommended':
        return const BookRecommendedCard(suggester: 'Ravindu');
      case 'Trending':
        return const BookTrendingCard(
          trendingNumber: 1,
        );
      case 'Wishlist':
        return const BookWishlistCard();
      case 'Completed':
        return const BookCompletedCard();
    }
    return const BookCard();
  }

  BookListView({super.key, required this.screenName});
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
