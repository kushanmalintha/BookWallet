import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A stateless widget that represents a list of books.
class GroupProfileScreenListView extends StatelessWidget {
  final String screenName;

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Reviews':
        return const ReviewCard(
          cardHeight: 190,
          backgroundColor: MyColors.panelColor,
          imagePath: 'images/Book_Image1.jpg',
          bookName: 'Dune Messiah',
          authorName: 'Frank Herbert',
          description:
              "Dune Messiah continues the story of Paul Atredes, now Emperor of the Known Universe and known as Muad'Dib. As he grapples with immense power, political enemies, and a conspiracy within his own",
          rating: 'Rating : 8.9/10',
          reviewedBy: 'Reviewed By : ',
          userName: 'Ravindu Pathirage',
        );
      case 'Books':
        return const BookCard();
    }
    return const BookCard();
  }

  const GroupProfileScreenListView({super.key, required this.screenName});
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
