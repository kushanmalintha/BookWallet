import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/controllers/checking_wishlist_controller.dart';
import 'package:book_wallert/controllers/wishlist_controller.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/services/checking_wishlist_service.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final BookRecommendController bookRecommendController =
        BookRecommendController(globalUser!.userId);
    final WishlistController wishlistController =
        WishlistController(WishlistApiService());
    final CheckingWishlistController checkingWishlistController =
        CheckingWishlistController(CheckingWishlistService());

    return GestureDetector(
      onTap: () {
        // Navigate to BookProfileScreenBody when the card is tapped
        screenChange(context, BookProfileScreenBody(book: book));
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        child: ListTile(
            iconColor: MyColors.nonSelectedItemColor,
            leading: SizedBox(
              width: 80,
              child: Image.network(
                  book.imageUrl, // Use imageUrl from the book object
                  scale: 1, errorBuilder: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Display error icon if image fails to load
              }),
            ),
            title: Text(
              book.title, // Use title from the book object
              style: const TextStyle(
                color: MyColors.textColor, // Text color
              ),
            ),
            subtitle: Text(
              '${book.author}\nPages: ${(book.pages == 0) ? '-' : book.pages}\nGenre: ${book.genre}\nTotal Rating: ${book.totalRating}/10',
              style: const TextStyle(
                color: MyColors.text2Color, // Text color
              ),
            ),
            trailing: FutureBuilder(
              future: bookRecommendController.fetchBookId(book).then((_) {
                return checkingWishlistController.checkWishlistStatus(
                    globalUser!.userId, bookRecommendController.bookId!);
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else {
                  return CustomPopupMenuButtons(items: [
                    'Recommend book to followers',
                    checkingWishlistController.isInWishlist
                        ? 'Remove from wishlist'
                        : 'Add to wishlist',
                  ], onItemTap: [
                    () async {
                      try {
                        await bookRecommendController.fetchBookId(book);
                        await bookRecommendController.postRecommendation(
                            globalUser!.userId,
                            bookRecommendController.bookId!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Book recommended to followers successfully.')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error recommending book: $e')),
                        );
                      }
                    },
                    () async {
                      try {
                        await bookRecommendController.fetchBookId(book);
                        if (checkingWishlistController.isInWishlist) {
                          // Remove from wishlist
                          // await wishlistController.removeBookFromWishlist(
                          //     globalUser!.userId,
                          //     bookRecommendController.bookId!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Book removed from wishlist successfully.')),
                          );
                        } else {
                          // Add to wishlist
                          await bookRecommendController.fetchBookId(book);
                          await wishlistController.addBookToWishlist(
                              globalUser!.userId,
                              bookRecommendController.bookId!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Book added to wishlist successfully.')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                  ], icon: const Icon(Icons.more_vert_rounded));
                }
              },
            )),
      ),
    );
  }
}
