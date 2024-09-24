import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/widgets/cards/user_req_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class GroupMemberReqListview extends StatefulWidget {
  final int groupId;

  const GroupMemberReqListview({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupMemberReqListview> createState() => _GroupMemberReqListviewState();
}

class _GroupMemberReqListviewState extends State<GroupMemberReqListview>
    with AutomaticKeepAliveClientMixin {
  late GroupController _groupController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true; // Keep alive when moving between list views

  @override
  void initState() {
    super.initState();
    _groupController = GroupController();
    _fetchMemberRequests();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMemberRequests();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch group member requests asynchronously
  void _fetchMemberRequests() async {
    setState(() {
      _isLoading = true;
    });

    await _groupController.fetchMemberRequestsByGroupId(widget.groupId,
        (updatedUsers) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Refresh handler (runs when the screen is pulled down to refresh)
  Future<void> _onRefresh() async {
    setState(() {
      _groupController.memberRequests = [];
    });
    await _groupController.fetchMemberRequestsByGroupId(widget.groupId,
        (updatedUsers) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure AutomaticKeepAliveClientMixin is honored
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _isLoading && _groupController.memberRequests.isEmpty
          ? Center(child: buildProgressIndicator())
          : _groupController.memberRequests.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No users',
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
                  controller: _scrollController,
                  itemCount: _groupController.memberRequests.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _groupController.memberRequests.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          UserReqCard(
                            user: _groupController.memberRequests[index],
                            group_id: widget.groupId,
                          ),
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator when fetching more data
                    }
                  },
                ),
    );
  }
}
