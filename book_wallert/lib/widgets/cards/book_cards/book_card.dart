import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/controllers/bookStatusController.dart';
import 'package:book_wallert/controllers/saved_controller.dart';
import 'package:book_wallert/controllers/wishlist_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/services/BookStatusService.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart';

class BookCard extends StatefulWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  // List of menu items
  List<String> items = [
    'Recommend book to followers',
    'Save book',
    'Add to wishlist',
  ];

  @override
  Widget build(BuildContext context) {
    final BookRecommendController bookRecommendController =
        BookRecommendController(globalUser!.userId);
    final WishlistController wishlistController =
        WishlistController(WishlistApiService());
    final bookStatusController = BookStatusController(BookStatusService());
    final savedController = SavedController(globalUser!.userId);

// Function to handle the logic when popup is opened
    Future<bool> onOpened(List<String> text) async {
      // Fetch the book ID asynchronously
      try {
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
        return false;
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigate to BookProfileScreenBody when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookProfileScreenBody(book: widget.book),
          ),
        );
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        child: ListTile(
          iconColor: MyColors.nonSelectedItemColor,
          leading: SizedBox(
            width: 80,
            child: Image.network(
              widget.book.imageUrl, // Use imageUrl from the book object
              scale: 1,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Display error icon if image fails to load
              },
            ),
          ),
          title: Text(
            widget.book.title, // Use title from the book object
            style: const TextStyle(
              color: MyColors.textColor, // Text color
            ),
          ),
          subtitle: Text(
            '${widget.book.author}\nPages: ${(widget.book.pages == 0) ? '-' : widget.book.pages}\nGenre: ${widget.book.genre}\nTotal Rating: ${widget.book.totalRating}/10',
            style: const TextStyle(
              color: MyColors.text2Color, // Text color
            ),
          ),
          trailing: CustomPopupMenuButtonsDynamic(
            onOpened: onOpened // Call the function to handle logic when opened
            ,
            items: items, // Pass the items list dynamically
            onItemTap: [
              () {
                // Recommend book
                bookRecommendController.recommendBookToFollowers(
                    context, widget.book);
              },
              () {
                // Save book
                savedController.insertBookToSaved(wishlistController
                    .bookId!); //book id take from wishlist controller
              },
              () {
                // Add or remove from wishlist
                wishlistController.addOrRemoveWishlistBook(
                  context,
                  widget.book,
                  bookStatusController.isInWishlist,
                );
              },
            ],
            icon: const Icon(
              Icons.more_vert_rounded,
              color: MyColors.nonSelectedItemColor,
            ),
          ),
        ),
      ),
    );
  }
}
