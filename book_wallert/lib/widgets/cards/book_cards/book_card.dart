import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        screenChange(context, const BookProfileScreenBody());
      },
      child: Card(
        // ListTile representing a book.
        color: MyColors.panelColor,
        child: ListTile(
          iconColor: MyColors.nonSelectedItemColor,
          leading: Image.asset(
            'images/Book_Image1.jpg',
            scale: 1,
          ), // Book cover image
          title: const Text(
            'Dune Messiah',
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          subtitle: const Text(
            'Frank Herbert\nPages: 256\nGenre: Science Fiction\nTotal Rating: 9.8/10',
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          // isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Add to wishlist action
            },
          ),
        ),
      ),
    );
  }
}
