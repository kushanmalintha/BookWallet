import 'package:book_wallert/colors.dart'; // Custom color definitions
import 'package:book_wallert/controllers/GroupController.dart'; // Controller to handle group-related operations
import 'package:book_wallert/widgets/cards/user_req_card.dart'; // Custom widget for displaying user request cards
import 'package:book_wallert/widgets/progress_indicators.dart'; // Custom progress indicator widget
import 'package:flutter/material.dart'; // Core Flutter package for UI building

class GroupMemberReqListview extends StatefulWidget {
  final int
      groupId; // Group ID passed to fetch member requests for a specific group

  const GroupMemberReqListview({
    super.key,
    required this.groupId, // Require the groupId parameter for this widget
  });

  @override
  State<GroupMemberReqListview> createState() => _GroupMemberReqListviewState();
}

class _GroupMemberReqListviewState extends State<GroupMemberReqListview> {
  late GroupController
      _groupController; // Controller instance to manage group member requests
  final ScrollController _scrollController =
      ScrollController(); // Scroll controller for handling infinite scrolling
  bool _isLoading =
      true; // Flag to track whether data is currently being loaded

  @override
  void initState() {
    super.initState();
    _groupController = GroupController(); // Initialize the GroupController
    _fetchMemberRequests(); // Fetch member requests when the widget is initialized

    // Listen for scroll events to implement infinite scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMemberRequests(); // Fetch more member requests when the user scrolls to the bottom
      }
    });
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose of the scroll controller to prevent memory leaks
    super.dispose();
  }

  // Fetch member requests for the group
  void _fetchMemberRequests() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // Fetch member requests from the controller using the groupId
    await _groupController.fetchMemberRequestsByGroupId(widget.groupId,
        (updatedUsers) {
      setState(() {
        _isLoading = false; // Set loading state to false once data is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MyColors.bgColor, // Set the background color of the scaffold
      body: _isLoading && _groupController.memberRequests.isEmpty
          ? Center(
              child:
                  buildProgressIndicator(), // Show loading indicator if data is being fetched and no requests are available yet
            )
          : _groupController.memberRequests.isEmpty
              ? const Center(
                  child: Text(
                    'No users',
                    style: TextStyle(
                        color: MyColors
                            .textColor), // Display a "No users" message if there are no member requests
                  ),
                )
              : ListView.builder(
                  controller:
                      _scrollController, // Attach the scroll controller to the list view
                  itemCount: _groupController.memberRequests.length +
                      (_isLoading
                          ? 1
                          : 0), // Show an extra item for loading indicator if data is still being fetched
                  itemBuilder: (context, index) {
                    if (index < _groupController.memberRequests.length) {
                      return Column(
                        children: [
                          const SizedBox(
                              height: 3), // Add spacing between request cards
                          UserReqCard(
                              user: _groupController.memberRequests[
                                  index]), // Use UserReqCard to display each user request
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator at the bottom if more data is being loaded
                    }
                  },
                ),
    );
  }
}
