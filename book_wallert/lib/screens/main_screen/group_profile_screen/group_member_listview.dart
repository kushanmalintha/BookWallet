import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class GroupMemberListview extends StatefulWidget {
  final int groupId;

  const GroupMemberListview({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupMemberListview> createState() => _GroupMemberListviewState();
}

class _GroupMemberListviewState extends State<GroupMemberListview> {
  late GroupController _groupController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _groupController = GroupController();
    _fetchMembers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMembers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMembers() async {
    setState(() {
      _isLoading = true;
    });

    await _groupController.fetchMembersByGroupId(widget.groupId,
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
      body: _isLoading && _groupController.groupMembers.isEmpty
          ? Center(
              child:
                  buildProgressIndicator(), // Show loading indicator if users are being fetched and list is empty
            )
          : _groupController.groupMembers.isEmpty
              ? const Center(
                  child: Text(
                    'No users',
                    style: TextStyle(color: MyColors.textColor),
                  ),
                ) // Show 'No users' message if the list is empty and no more data is being loaded
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _groupController.groupMembers.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _groupController.groupMembers.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          UserCard(
                              user: _groupController.groupMembers[
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
