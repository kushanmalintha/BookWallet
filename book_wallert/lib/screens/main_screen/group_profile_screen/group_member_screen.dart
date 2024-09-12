import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_listview.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class GroupMembersScreenBody extends StatefulWidget {
  final int groupId;
  const GroupMembersScreenBody({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupMembersScreenBody> createState() {
    return _GroupMembersScreenBodyState();
  }
}

class _GroupMembersScreenBodyState extends State<GroupMembersScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabNames = [
    'Members',
    'Requested',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: MyColors.bgColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child:
              SelectionBar(tabController: _tabController, tabNames: _tabNames),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Add widgets for each tab
          GroupMemberListview(groupId: widget.groupId),
          GroupMemberListview(groupId: widget.groupId),
        ],
      ),
    );
  }
}
