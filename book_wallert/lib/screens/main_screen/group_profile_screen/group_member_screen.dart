import 'package:book_wallert/controllers/groupController.dart'; // Controller to manage group-related logic
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_listview.dart'; // Screen for displaying group members
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_req_listview.dart'; // Screen for displaying requested members (pending approval)
import 'package:flutter/material.dart'; // Flutter core package for building UI
import 'package:book_wallert/colors.dart'; // Custom colors used in the app
import 'package:book_wallert/widgets/buttons/selection_bar.dart'; // Custom widget for displaying tab selection

class GroupMembersScreenBody extends StatefulWidget {
  final int groupId; // ID of the group for which members are being displayed

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
  TabController?
      _tabController; // Controller for managing tab selection and interaction
  List<String> _tabNames = ['Members']; // Default tab is "Members"
  bool isAdmin = false; // Boolean to track whether the user is an admin
  final GroupController _groupController =
      GroupController(); // Instance of the GroupController to handle logic

  @override
  void initState() {
    super.initState();
    _checkAdminStatus(); // Check if the user is an admin when the screen is initialized
  }

  // Method to create the TabController, used after we determine if the user is an admin
  void _createTabController() {
    _tabController = TabController(
        length: _tabNames.length,
        vsync:
            this); // Initialize TabController with the updated number of tabs
  }

  // Method to check the admin status of the user in the group
  Future<void> _checkAdminStatus() async {
    await _groupController.checkAdminStatus(widget.groupId, (isAdminStatus) {
      setState(() {
        isAdmin = isAdminStatus; // Update the isAdmin flag based on the result
        if (isAdmin) {
          _tabNames.add(
              'Requested'); // Add the "Requested" tab if the user is an admin
        }
        _createTabController(); // Recreate the TabController after updating the tab list
      });
    });
  }

  @override
  void dispose() {
    _tabController
        ?.dispose(); // Dispose of the TabController when the screen is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MyColors.bgColor, // Set the background color for the scaffold
      appBar: AppBar(
        toolbarHeight:
            1, // Reduce the height of the AppBar (used for aesthetics)
        backgroundColor: MyColors
            .bgColor, // Set the AppBar background color to match the screen
        bottom: _tabController != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(
                    50.0), // Set the height of the tab selection bar
                child: SelectionBar(
                  tabController:
                      _tabController!, // Attach the TabController to the selection bar
                  tabNames:
                      _tabNames, // Pass the tab names (Members, and potentially Requested) to the selection bar
                ),
              )
            : null, // No tab selection bar if the TabController isn't created yet
      ),
      body: _tabController != null
          ? TabBarView(
              controller:
                  _tabController!, // Use the TabController for managing tabs
              children: [
                GroupMemberListview(
                    groupId:
                        widget.groupId), // First tab: list of group members
                if (isAdmin)
                  GroupMemberReqListview(
                    groupId: widget.groupId,
                  ), // Second tab: requested members (only visible if the user is an admin)
              ],
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator while the TabController is being created
            ),
    );
  }
}
