// book_profile_screen_location_list_view.dart
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/review_for_book_controller.dart';
import 'package:book_wallert/widgets/cards/locations_card.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/store_managing_controller.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';

class BookProfileScreenShopListView extends StatefulWidget {
  final String screenName;
  final BookModel book;

  const BookProfileScreenShopListView({
    super.key,
    required this.screenName,
    required this.book,
  });

  @override
  State<BookProfileScreenShopListView> createState() =>
      _BookProfileScreenShopListViewState();
}

class _BookProfileScreenShopListViewState
    extends State<BookProfileScreenShopListView>
    with AutomaticKeepAliveClientMixin {
  final ShopController _shopController = ShopController();
  final ReviewForBookController _reviewForBookController =
      ReviewForBookController();
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    try {
      // Fetch the book ID
      await _reviewForBookController.fetchId(widget.book);

      // Use the fetched book ID to fetch shops
      int bookId = _reviewForBookController.bookId!;
      await _shopController.fetchShops(bookId);

      // Update the state to reflect the fetched data
      setState(() {});
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _shopController.shops = [];
    });
    await _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _shopController.isLoading
          ? Center(child: buildProgressIndicator())
          : _shopController.shops.isEmpty
              ? const Center(
                  child: Text('No shops found',
                      style: TextStyle(color: MyColors.textColor)),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _shopController.shops.length,
                  itemBuilder: (context, index) {
                    return LocationsCard(shop: _shopController.shops[index]);
                  },
                ),
    );
  }
}
