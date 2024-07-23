import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookTrendingCard extends StatelessWidget {
  final BookModel book;
  final int trendingNumber;

  const BookTrendingCard({
    super.key,
    required this.book,
    required this.trendingNumber,
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
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#$trendingNumber',
                style: const TextStyle(
                  color: MyColors.textColor, // Text color
                  fontWeight: FontWeight.bold, // Bold font weight
                ),
              ),
              const SizedBox(
                  width: 8), // Space between the number and the image
              Image.network(
                book.imageUrl, // Use imageUrl from the book object
                scale: 1,
              ),
            ],
          ),
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
