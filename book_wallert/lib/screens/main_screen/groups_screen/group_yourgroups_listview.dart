import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_yourgroup.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

// Stateful widget to display a list of groups the user belongs to
class YourGroupListView extends StatefulWidget {
  final int globalUserId; // User's ID passed from the parent widget

  const YourGroupListView({
    super.key,
    required this.globalUserId, // Ensures globalUserId is passed when the widget is created
  });

  @override
  State<YourGroupListView> createState() => _YourGroupListViewState();
}

class _YourGroupListViewState extends State<YourGroupListView> {
  late GroupController
      _groupController; // Instance of GroupController to fetch and manage group data
  final ScrollController _scrollController =
      ScrollController(); // Controller for handling scroll events
  bool _isLoading = true; // Tracks whether the data is currently being loaded

  @override
  void initState() {
    super.initState();
    _groupController = GroupController(); // Initialize the group controller
    _fetchMoreGroups(); // Fetch initial set of groups

    // Add listener for infinite scrolling
    _scrollController.addListener(() {
      // Check if the user has scrolled to the bottom of the list
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreGroups(); // Fetch more groups when reaching the bottom
      }
    });
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Clean up the scroll controller when the widget is disposed
    super.dispose();
  }

  // Method to fetch more groups for the user
  void _fetchMoreGroups() async {
    setState(() {
      _isLoading = true; // Set loading state to true before fetching data
    });

    // Fetch groups using the group controller, passing a callback to update the state
    await _groupController.fetchGroupsByUserId((updatedGroups) {
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

      // If groups are still being loaded and no groups are currently available
      body: _isLoading && _groupController.groups.isEmpty
          ? Center(child: buildProgressIndicator()) // Show loading indicator

          // If no groups are found
          : _groupController.groups.isEmpty
              ? const Center(
                  child: Text('No groups found',
                      style: TextStyle(
                          color: MyColors
                              .textColor)), // Display message when no groups are found
                )

              // Display the list of groups
              : ListView.builder(
                  controller:
                      _scrollController, // Attach the scroll controller to detect scrolling events
                  itemCount: _groupController.groups.length +
                      (_isLoading
                          ? 1
                          : 0), // Add an extra item for the loading indicator if still loading

                  // Build each list item
                  itemBuilder: (context, index) {
                    if (index < _groupController.groups.length) {
                      return Column(
                        children: [
                          const SizedBox(
                              height: 3), // Add space between the group cards
                          GroupCardYourgroup(
                            group: _groupController.groups[
                                index], // Pass each group to the custom GroupCard widget
                          ),
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator while fetching more groups
                    }
                  },
                ),
    );
  }
}
