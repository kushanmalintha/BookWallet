import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BookCompletedCard extends StatelessWidget {
  final BookModel book;

  const BookCompletedCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to BookProfileScreenBody when the card is tapped
        screenChange(context, BookProfileScreenBody(book: dummyBook));
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        child: ListTile(
          iconColor: MyColors.nonSelectedItemColor,
          leading:
              Image.network(book.imageUrl, // Use imageUrl from the book object
                  scale: 1, errorBuilder: (context, error, stackTrace) {
            return const Icon(
                Icons.error); // Display error icon if image fails to load
          }),
          title: Text(
            book.title, // Use title from the book object
            style: const TextStyle(
              color: MyColors.textColor, // Text color
            ),
          ),
          subtitle: Text(
            '${book.author}\nPages: ${book.pages}\nGenre: ${book.genre}\nTotal Rating: ${book.totalRating}/10',
            style: const TextStyle(
              color: MyColors.text2Color, // Text color
            ),
          ),
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
