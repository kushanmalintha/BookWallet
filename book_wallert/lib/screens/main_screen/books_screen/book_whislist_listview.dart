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

class _BookWishlistListViewState extends State<BookWishlistListView>
    with AutomaticKeepAliveClientMixin {
  // AutomaticKeepAliveClientMixin added to make sure scroll view remains same when moving to other listviews in same screen
  @override
  bool get wantKeepAlive =>
      true; // Keep alive even when move to diffeerent listview

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

  // Refresh handler (this function runs on refresh sceen)
  Future<void> _onRefresh() async {
    setState(() {
      _wishlistController.wishlistBooks = [];
    });

    _fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      // Add the ability to refresh screen when pull down
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _wishlistController.isLoading
          ? Center(child: buildProgressIndicator())
          : _wishlistController.wishlistBooks.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const Center(
                        child: Text(
                          'No books in Wishlist',
                          style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _wishlistController.wishlistBooks.length,
                  itemBuilder: (context, index) {
                    return BookCard(
                        book: _wishlistController.wishlistBooks[index]);
                  },
                ),
    );
  }
}
