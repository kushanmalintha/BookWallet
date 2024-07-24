import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/frames/book_reading_progress_bar.dart';
import 'package:flutter/material.dart';

class BookReadingProgressBarListView extends StatelessWidget {
  const BookReadingProgressBarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Number of items in the list.
      itemCount: 10, // Change this to the number of books
      // Builder function for each list item.
      itemBuilder: (context, index) {
        return BookReadingProgressBar(
          progress: 0.65,
          child: BookCard(book: dummyBook),
        ); //
      },
    );
  }
}
