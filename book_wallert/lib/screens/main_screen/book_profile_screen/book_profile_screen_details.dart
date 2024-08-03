import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

import '../../../widgets/buttons/custom_popup_menu_buttons.dart'; // Import your BookModel class

class BookProfileScreenDetails extends StatelessWidget {
  final BookModel book;

  const BookProfileScreenDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 0,
          color: MyColors.bgColor,
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 250,
                // width: 400,
                child: Image.network(
                  book.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                book.title, // Use the title from the BookModel object
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'Author: ${book.author}', // Use the author from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'Genre: ${book.genre}', // Use the genre from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'Rating: ${book.totalRating}/5', // Use the totalRating from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'Pages: ${book.pages}', // Use the pages from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'ISBN10: ${book.ISBN10}', // Use the ISBN from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'ISBN13: ${book.ISBN13}', // Use the ISBN from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                'Published Date: ${book.publishedDate}', // Use the ISBN from the BookModel object
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Text(
                book.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Resource: ${book.resource}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.textColor.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 14,
          right: 10,
          child: CustomPopupMenuButtons(
              items: const [
                'Share',
                'Block',
                'Report',
                'Add to Wishlist'
              ],
              onItemTap: [
                // Item actions
                () {
                  print("Share");
                },
                () {
                  print("Block");
                },
                () {
                  print("Report");
                },
                () {
                  print("Add to Wishlist");
                },
              ],
              icon: const Icon(
                Icons.more_vert_rounded,
                color: MyColors.nonSelectedItemColor,
              )),
        )
      ],
    );
  }
}

