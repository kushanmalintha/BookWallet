import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/history_controller.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

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

    await _historyController.fetchUsers((updatedUsers) {
      setState(() {
        _isLoading = false;
      });
    });
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
