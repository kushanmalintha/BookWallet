import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/wishlist_controller.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
//import 'wishlist_controller.dart';
//import 'book_card.dart'; // Assuming you have a BookCard widget

class BookWishlistListView extends StatefulWidget {
  final int userId;

  const BookWishlistListView({super.key, required this.userId});

  @override
  State<BookWishlistListView> createState() => _BookWishlistListViewState();
}

class _BookWishlistListViewState extends State<BookWishlistListView> {
  late WishlistController _wishlistController;

  @override
  void initState() {
    super.initState();
    _wishlistController = WishlistController(WishlistApiService());
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    await _wishlistController.fetchWishlist(widget.userId);
    setState(() {}); // Update the state to refresh the UI after data is fetched
  }

  @override
  Widget build(BuildContext context) {
    return _wishlistController.isLoading
        ? Center(child: buildProgressIndicator())
        : _wishlistController.wishlistBooks.isEmpty
            ? const Center(
                child: Text('No books in Wishlist',
                    style: TextStyle(color: MyColors.textColor)))
            : ListView.builder(
                itemCount: _wishlistController.wishlistBooks.length,
                itemBuilder: (context, index) {
                  return BookCard(
                      book: _wishlistController.wishlistBooks[index]);
                },
              );
  }
}
