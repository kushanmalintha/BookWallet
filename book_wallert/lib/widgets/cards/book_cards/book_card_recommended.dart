import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookRecommendedCard extends StatelessWidget {
  final BookModel book;
  final String suggester;

  const BookRecommendedCard({
    super.key,
    required this.book,
    required this.suggester,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to BookProfileScreenBody when the card is tapped
        screenChange(context, BookProfileScreenBody( book: dummyBook));
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        child: ListTile(
          iconColor: MyColors.nonSelectedItemColor,
          leading: Image.asset(
            book.imageUrl, // Use imageUrl from the book object
            scale: 1,
          ),
          title: Text(
            book.title, // Use title from the book object
            style: const TextStyle(
              color: MyColors.textColor, // Text color
            ),
          ),
          subtitle: Text(
            '${book.author}\nPages: ${book.pages}\nGenre: ${book.genre}\nTotal Rating: ${book.totalRating}/10\nSuggested by: $suggester',
            style: const TextStyle(
              color: MyColors.textColor, // Text color
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
