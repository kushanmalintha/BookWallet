import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BookTrendingCard extends StatelessWidget {
  final int trendingNumber;

  const BookTrendingCard({
    super.key,
    required this.trendingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        screenChange(context, const BookProfileScreenBody());
      },
      child: Card(
        color: MyColors.panelColor,
        child: ListTile(
          iconColor: MyColors.nonSelectedItemColor,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#$trendingNumber',
                style: const TextStyle(
                  color: MyColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  width: 8), // Space between the number and the image
              Image.asset(
                'images/Book_Image1.jpg',
                scale: 1,
              ),
            ],
          ),
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
