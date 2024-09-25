import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/controllers/bookStatusController.dart';
import 'package:book_wallert/controllers/saved_controller.dart';
import 'package:book_wallert/controllers/wishlist_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/services/BookStatusService.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookProfileScreenDetails extends StatelessWidget {
  final BookModel book;
  List<String> items = [
    'Recommend book to followers',
    'Save book',
    'Add to wishlist',
  ];

  BookProfileScreenDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final BookRecommendController bookRecommendController =
        BookRecommendController(globalUser!.userId);
    final WishlistController wishlistController =
        WishlistController(WishlistApiService());
    final bookStatusController = BookStatusController(BookStatusService());

    // final CheckingWishlistController checkingWishlistController =
    //     CheckingWishlistController(CheckingWishlistService());
    final savedController = SavedController(globalUser!.userId);
    Future<bool> onOpened(List<String> text) async {
      try {
        await wishlistController.fetchBookId(book);
        // Check the book ID before proceeding
        if (wishlistController.bookId == null) {
          print('Book ID is null');
          return false;
        }

        // Fetch the book's status (wishlist and saved status)
        await bookStatusController.checkBookStatus(
            globalUser!.userId, wishlistController.bookId!);

        // Modify the popup items based on the fetched status
        if (bookStatusController.isInWishlist) {
          text[2] = 'Remove from wishlist'; // Modify the wishlist text
        } else {
          text[2] = 'Add to wishlist';
        }

        if (bookStatusController.isSaved) {
          text[1] = 'Remove from saved books'; // Modify the save text
        } else {
          text[1] = 'Save book';
        }

        return true;
      } catch (e) {
        print('Error in onOpened: $e');
        return false;
      }
    }

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
          child: CustomPopupMenuButtonsDynamic(
            onOpened: onOpened, // Call the function to handle logic when opened
            items: items, // Pass the items list dynamically
            onItemTap: [
              () {
                // Recommend book
                bookRecommendController.recommendBookToFollowers(context, book);
              },
              () {
                // Save book or remove from saved
                if (bookStatusController.isSaved) {
                  savedController
                      .removeBookFromSaved(context,wishlistController.bookId!);
                } else {
                  savedController.insertBookToSaved(context, wishlistController.bookId!);
                }
              },
              () {
                //add wishlist and remove wishlist
                if (bookStatusController.isInWishlist) {
                  wishlistController
                      .removeBookFromWishlist(context, wishlistController.bookId!);
                } else {
                  wishlistController
                      .addBookToWishlist(context, wishlistController.bookId!);
                }
              },
            ],
            icon: const Icon(
              Icons.more_vert_rounded,
              color: MyColors.nonSelectedItemColor,
            ),
          ),
        ),
      ],
    );
  }
}
