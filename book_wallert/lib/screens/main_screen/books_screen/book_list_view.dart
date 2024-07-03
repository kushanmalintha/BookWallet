import 'package:flutter/material.dart';
import 'package:book_wallert/cards/book_card.dart';

// A stateless widget that represents a list of books.
class BookListView extends StatelessWidget {
  const BookListView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Number of items in the list.
      itemCount: 10, // Change this to the number of books
      // Builder function for each list item.
      itemBuilder: (context, index) {
        return const BookCard();
      },
    );
  }
}
