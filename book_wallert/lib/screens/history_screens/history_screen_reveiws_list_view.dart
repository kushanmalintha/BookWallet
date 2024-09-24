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

class _HistoryListListViewReviewsState extends State<HistoryListViewReviews> 
with AutomaticKeepAliveClientMixin  {
  late HistoryController _historyController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

   @override
  bool get wantKeepAlive => true;

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

  Future<void> _onRefresh() async {
    setState(() {
      _historyController.historyReviews = []; // Clear reviews before refresh
    });
   await _historyController.fetchReviews((updatedReviews) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for keeping state alive

    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _historyController.historyReviews.isEmpty
          ? Center(child: buildProgressIndicator())
          : _historyController.historyReviews.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No Reviews',
                          style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              :  ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
    ));
  }
}
