import 'package:book_wallert/cards/review_card.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A stateless widget that represents a list of books.
class GroupProfileListView extends StatelessWidget {
  const GroupProfileListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Review(
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
        },
      ),
    );
  }
}
