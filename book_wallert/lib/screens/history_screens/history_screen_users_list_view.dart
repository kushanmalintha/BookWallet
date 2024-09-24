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

class _HistoryListUserState extends State<HistoryListViewUser> 
with AutomaticKeepAliveClientMixin {
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

    await _historyController.fetchUsers((updatedUsers) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _historyController.historyUsers = []; // Clear reviews before refresh
    });
   await _historyController.fetchUsers((updatedUsers) {
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
      body: _isLoading && _historyController.historyUsers.isEmpty
          ? Center(
              child:
                  buildProgressIndicator()) // Show loading indicator if users are being fetched and list is empty
          : _historyController.historyUsers.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No Users',
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
    ));
  }
}
