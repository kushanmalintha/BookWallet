import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/history_controller.dart';

class HistoryListViewAll extends StatefulWidget {
  final int userId;

  const HistoryListViewAll({
    super.key,
    required this.userId,
  });

  @override
  State<HistoryListViewAll> createState() => _HistoryListViewAllState();
}

class _HistoryListViewAllState extends State<HistoryListViewAll>
with AutomaticKeepAliveClientMixin  {
  late HistoryController _historyController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isFetchingMore = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _historyController = HistoryController(widget.userId);
    _fetchMoreData();

    // Add listener to scroll controller for infinite scrolling
    _scrollController.addListener(() {
      if (!_isFetchingMore &&
          _scrollController.position.pixels ==
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

    await _historyController.fetchAllItems((updatedallItems) {
      setState(() {
        _isLoading = false;
      });
    });
  }

 Future<void> _onRefresh() async {
    setState(() {
      _historyController.allItems = []; // Clear reviews before refresh
    });
   await _historyController.fetchAllItems((updatedallItems) {
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
      child:
     Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _historyController.allItems.isEmpty
          ? Center(
              child: buildProgressIndicator(),
            )
          : _historyController.allItems.isEmpty
              ? const Center(
                  child: Text(
                    'No items',
                    style: TextStyle(color: MyColors.textColor),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      _historyController.allItems.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _historyController.allItems.length) {
                      final item = _historyController.allItems[index];

                      switch (item['type']) {
                        case 'review':
                          ReviewModel review =
                              ReviewModel.fromJson(item['post']);
                          return Column(
                            children: [
                              const SizedBox(height: 3),
                              ReviewCard(review: review),
                            ],
                          );

                        case 'book':
                          BookModel book = BookModel.fromJson(item['book']);
                          return Column(
                            children: [
                              const SizedBox(height: 3),
                              BookCard(book: book),
                            ],
                          );

                        case 'user':
                          User user = User.fromJson(item['userDetails']);
                          return Column(
                            children: [
                              const SizedBox(height: 3),
                              UserCard(user: user),
                            ],
                          );

                        default:
                          return const SizedBox
                              .shrink(); // If the type is unknown
                      }
                    } else {
                      return buildProgressIndicator(); // Show loading indicator when more data is being fetched
                    }
                  },
                ),
    ));
  }
}
