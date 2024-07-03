import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

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
        return Card(
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
        );
      },
    );
  }
}
