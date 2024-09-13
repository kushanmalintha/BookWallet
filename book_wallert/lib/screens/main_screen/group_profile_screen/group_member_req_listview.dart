import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/GroupController.dart';
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

class _GroupMemberReqListviewState extends State<GroupMemberReqListview> {
  late GroupController _groupController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _groupController.memberRequests.isEmpty
          ? Center(
              child:
                  buildProgressIndicator(), // Show loading indicator if users are being fetched and list is empty
            )
          : _groupController.memberRequests.isEmpty
              ? const Center(
                  child: Text(
                    'No users',
                    style: TextStyle(color: MyColors.textColor),
                  ),
                ) // Show 'No users' message if the list is empty and no more data is being loaded
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _groupController.memberRequests.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _groupController.memberRequests.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          UserReqCard(
                              user: _groupController.memberRequests[
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
