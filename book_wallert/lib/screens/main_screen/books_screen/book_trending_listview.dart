import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/trending_controller.dart';
import 'package:book_wallert/services/trending_service.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/frames/trendingwidget_frame.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class TrendingListView extends StatefulWidget {
  const TrendingListView({super.key});

  @override
  State<TrendingListView> createState() => _TrendingListViewState();
}

class _TrendingListViewState extends State<TrendingListView>
    with AutomaticKeepAliveClientMixin {
  // AutomaticKeepAliveClientMixin added to make sure scroll view remains same when moving to other listviews in same screen
  @override
  bool get wantKeepAlive =>
      true; // Keep alive even when move to diffeerent listview

  late TrendingController _trendingController;

  @override
  void initState() {
    super.initState();
    _trendingController = TrendingController(TrendingService());
    _fetchTrendingBooks();
  }

  Future<void> _fetchTrendingBooks() async {
    await _trendingController.fetchTrendingBooks();
    setState(() {}); // Update the state to refresh the UI after data is fetched
  }

  // Refresh handler (this function runs on refresh sceen)
  Future<void> _onRefresh() async {
    setState(() {
      _trendingController.trendingBooks = [];
    });

    _fetchTrendingBooks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      // Add the ability to refresh screen when pull down
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _trendingController.isLoading
          ? Center(child: buildProgressIndicator())
          : _trendingController.trendingBooks.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No trending books available',
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
                  itemCount: _trendingController.trendingBooks.length,
                  itemBuilder: (context, index) {
                    return TrendingFrame(
                      rank: index + 1, // Rank increases with index
                      child: BookCard(
                        book: _trendingController.trendingBooks[index],
                      ),
                    );
                  },
                ),
    );
  }
}
