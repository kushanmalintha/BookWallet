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
  _TrendingListViewState createState() => _TrendingListViewState();
}

class _TrendingListViewState extends State<TrendingListView> {
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

  @override
  Widget build(BuildContext context) {
    return _trendingController.isLoading
        ? Center(child: buildProgressIndicator())
        : _trendingController.trendingBooks.isEmpty
            ? const Center(
                child: Text('No trending books available',
                    style: TextStyle(color: MyColors.textColor)))
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
              );
  }
}
