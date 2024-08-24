import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/history_controller.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class HistoryListViewReviews extends StatefulWidget {
  final int userId;

  const HistoryListViewReviews({
    super.key,
    required this.userId,
  });

  @override
  State<HistoryListViewReviews> createState() =>
      _HistoryListListViewReviewsState();
}

class _HistoryListListViewReviewsState extends State<HistoryListViewReviews> {
  late HistoryController _historyController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _historyController = HistoryController(widget.userId);
    _fetchMoreData();

    // Add listener to scroll controller for infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMoreData() async {
    setState(() {
      _isLoading = true;
    });

    await _historyController.fetchReviews((updatedReviews) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _historyController.historyReviews.isEmpty
          ? Center(child: buildProgressIndicator())
          : _historyController.historyReviews.isEmpty
              ? const Center(
                  child: Text('No reviews',
                      style: TextStyle(color: MyColors.textColor)))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _historyController.historyReviews.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _historyController.historyReviews.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          ReviewCard(
                              review: _historyController.historyReviews[index]),
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator when more data is being fetched
                    }
                  },
                ),
    );
  }
}
