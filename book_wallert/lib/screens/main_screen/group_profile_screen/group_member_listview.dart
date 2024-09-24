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

class _GroupMemberListviewState extends State<GroupMemberListview>
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

  // Fetch group members asynchronously
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

  // Refresh handler (runs when the screen is pulled down to refresh)
  Future<void> _onRefresh() async {
    setState(() {
      _groupController.groupMembers = [];
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
    super.build(context);
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _isLoading && _groupController.groupMembers.isEmpty
          ? Center(child: buildProgressIndicator())
          : _groupController.groupMembers.isEmpty
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
                  itemCount: _groupController.groupMembers.length +
                      (_isLoading ? 1 : 0), // Add an extra item if loading
                  itemBuilder: (context, index) {
                    if (index < _groupController.groupMembers.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          UserCard(
                            user: _groupController.groupMembers[index],
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
