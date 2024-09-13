import 'package:book_wallert/controllers/groupController.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_listview.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_req_listview.dart';
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
  TabController? _tabController;
  List<String> _tabNames = ['Members'];
  bool isAdmin = false; // Track whether the user is an admin
  final GroupController _groupController = GroupController();

  @override
  void initState() {
    super.initState();
    _checkAdminStatus(); // Check admin status on init
  }

  // Create TabController after checking admin status
  void _createTabController() {
    _tabController = TabController(length: _tabNames.length, vsync: this);
  }

  Future<void> _checkAdminStatus() async {
    await _groupController.checkAdminStatus(widget.groupId, (isAdminStatus) {
      setState(() {
        isAdmin = isAdminStatus;
        if (isAdmin) {
          _tabNames
              .add('Requested'); // Add the "Requested" tab if user is admin
        }
        _createTabController(); // Create TabController after tabNames are updated
      });
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: MyColors.bgColor,
        bottom: _tabController != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: SelectionBar(
                  tabController: _tabController!,
                  tabNames: _tabNames,
                ),
              )
            : null,
      ),
      body: _tabController != null
          ? TabBarView(
              controller: _tabController!,
              children: [
                GroupMemberListview(groupId: widget.groupId),
                if (isAdmin)
                  GroupMemberReqListview(
                    groupId: widget.groupId,
                  ), // Only show if user is admin
              ],
            )
          : Center(
              child:
                  CircularProgressIndicator()), // Loading indicator while tab controller is created
    );
  }
}
