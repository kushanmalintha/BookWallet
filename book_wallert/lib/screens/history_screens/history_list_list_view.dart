import 'package:book_wallert/dummy_data/group_dummy_data.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_yourgroup.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/history_controller.dart';

class HistoryListViewAll extends StatelessWidget {
  const HistoryListViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return GroupCardYourgroup(group: dummyGroup);
        },
      ),
    );
  }
}

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

class HistoryListViewBooks extends StatefulWidget {
  final int userId;

  const HistoryListViewBooks({
    super.key,
    required this.userId,
  });

  @override
  State<HistoryListViewBooks> createState() => _HistoryListViewBooksState();
}

class _HistoryListViewBooksState extends State<HistoryListViewBooks> {
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

    await _historyController.fetchBooks((updatedBooks) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _historyController.historyBooks.isEmpty
          ? Center(child: buildProgressIndicator())
          : _historyController.historyBooks.isEmpty
              ? const Center(
                  child: Text('No books',
                      style: TextStyle(color: MyColors.textColor)))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _historyController.historyBooks.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _historyController.historyBooks.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          BookCard(
                              book: _historyController.historyBooks[index]),
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

class HistoryListViewUser extends StatefulWidget {
  final int userId;

  const HistoryListViewUser({
    super.key,
    required this.userId,
  });

  @override
  State<HistoryListViewUser> createState() => _HistoryListUserState();
}

class _HistoryListUserState extends State<HistoryListViewUser> {
  late HistoryController _historyController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _hasMore = true; // To track if more data is available

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

    try {
      await _historyController.fetchUsers((updatedUsers) {
        setState(() {
          _isLoading = false;
          _hasMore = updatedUsers.isNotEmpty; // Update based on the response
          if (_hasMore) {
            _historyController.historyUsers.addAll(updatedUsers);
          }
        });
      });
    } catch (e) {
      // Handle errors here
      print('Error fetching users: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _historyController.historyUsers.isEmpty
          ? Center(
              child:
                  buildProgressIndicator()) // Show loading indicator if users are being fetched and list is empty
          : _historyController.historyUsers.isEmpty
              ? const Center(
                  child: Text(
                    'No users',
                    style: TextStyle(color: MyColors.textColor),
                  ),
                ) // Show 'No users' message if the list is empty and no more data is being loaded
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _historyController.historyUsers.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _historyController.historyUsers.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          UserCard(
                              user: _historyController.historyUsers[
                                  index]), // Use UserCard for displaying users
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
