import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BookRecommendedCard extends StatelessWidget {
  final String suggester;

  const BookRecommendedCard({
    super.key,
    required this.suggester,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
        subtitle: Text(
          'Frank Herbert\nPages: 256\nGenre: Science Fiction\nTotal Rating: 9.8/10\nSuggested by: $suggester',
          style: const TextStyle(
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
    );
  }
}
