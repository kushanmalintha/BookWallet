import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/widgets/frames/trendingwidget_frame.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card_recommended.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card_trending.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card_wishlist.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card_completed.dart';

// A stateless widget that represents a list of books.
class BookListView extends StatelessWidget {
  final String screenName;

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Recommended':
        return BookRecommendedCard(
          suggester: 'Ravindu',
          book: dummyBook,
        );
      case 'Trending':
        return TrendingFrame(
          rank: 1,
          child: BookCard(
            book: dummyBook,
          ),
        );
      case 'Wishlist':
        return BookCard(
          book: dummyBook,
        );
      case 'Completed':
        return BookCard(
          book: dummyBook,
        );
    }
    return BookCard(
      book: dummyBook,
    );
  }

  const BookListView({super.key, required this.screenName});
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
