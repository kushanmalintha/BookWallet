import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_body.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/group_model.dart';

// Stateful widget representing each group card in the "Your Groups" list
class GroupCardYourgroup extends StatefulWidget {
  final GroupModel group; // Group data passed from parent widget

  const GroupCardYourgroup({
    super.key,
    required this.group, // Ensure group data is provided when the widget is created
  });

  @override
  _GroupCardYourgroupState createState() => _GroupCardYourgroupState();
}

class _GroupCardYourgroupState extends State<GroupCardYourgroup> {
  final GroupController _groupController =
      GroupController(); // Group controller to handle requests
  bool _isRequestSent = false; // Track if a join request has been sent

  @override
  void initState() {
    super.initState();
    _checkMembershipStatus(); // Check the initial membership status of the user
  }

  // Check if the user has already sent a join request to this group
  Future<void> _checkMembershipStatus() async {
    try {
      // Check membership status from the group model and update the request state
      if (widget.group.membershipStatus == 'requested') {
        setState(() {
          _isRequestSent = true; // If a request was sent, mark it as true
        });
      } else {
        setState(() {
          _isRequestSent = false; // If not, mark it as false
        });
      }
    } catch (e) {
      // Handle any errors that occur while checking the status
      print('Error checking membership status: $e');
    }
  }

  // Send a join request to the group
  Future<void> _sendRequest() async {
    if (globalUser?.userId != null) {
      // Ensure globalUser exists, then send the request via GroupController
      final success =
          await _groupController.sendJoinRequest(widget.group.group_id);
      if (success) {
        setState(() {
          _isRequestSent = true; // Update state if request was successful
        });
      } else {
        print('Failed to send request'); // Log error if the request fails
      }
    }
  }

  // Cancel the previously sent join request
  Future<void> _cancelRequest() async {
    if (globalUser?.userId != null) {
      // Ensure globalUser exists, then send the cancel request via GroupController
      final success =
          await _groupController.cancelJoinRequest(widget.group.group_id);
      if (success) {
        setState(() {
          _isRequestSent =
              false; // Update state if the cancel request was successful
        });
      } else {
        print(
            'Failed to cancel request'); // Log error if the cancel request fails
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Group Profile screen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupProfileScreenBody(
              groupId: widget
                  .group.group_id, // Pass group ID to the GroupProfileScreen
            ),
          ),
        );
      },
      child: Card(
        color: MyColors.panelColor, // Set card background color
        margin: const EdgeInsets.all(5), // Card margins
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Card content padding
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content at the top
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage(widget.group.imageUrl), // Group image
                radius: 25, // Circle avatar size
              ),
              const SizedBox(width: 10), // Spacing between avatar and text
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to the left
                  children: [
                    Text(
                      widget.group.name, // Group name
                      style: const TextStyle(
                        color: MyColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Bold text for group name
                      ),
                    ),
                    const SizedBox(height: 10), // Spacing below the group name
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Spread members and discussions info across the row
                      children: [
                        Text(
                          'Members: ${widget.group.memberCount}', // Display member count
                          style: const TextStyle(color: MyColors.text2Color),
                        ),
                        Text(
                          'Discussions: ${widget.group.discussionCount}', // Display discussion count
                          style: const TextStyle(color: MyColors.text2Color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6), // Spacing before the button row
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Align buttons at the bottom
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align buttons to the right
                      children: [
                        // Check membership status to determine which button to show
                        if (widget.group.membershipStatus == 'member') ...[
                          // No button shown if the user is already a member
                        ] else if (_isRequestSent) ...[
                          // Show a button to cancel the request if the request has been sent
                          CustomToggleButton1(
                            isSelected: true,
                            beforeText: 'Send Request',
                            afterText: 'Requested',
                            press:
                                _cancelRequest, // Call cancel request function
                            verticalalSpace: 7,
                            horizontalSpace: 12,
                            textSize: 12, // Styling for the button
                          ),
                        ] else ...[
                          // Show a button to send a request if no request is sent
                          CustomToggleButton1(
                            isSelected: false,
                            beforeText: 'Send Request',
                            afterText: 'Requested',
                            press: _sendRequest, // Call send request function
                            verticalalSpace: 7,
                            horizontalSpace: 12,
                            textSize: 12, // Styling for the button
                          ),
                        ],
                        const SizedBox(width: 15), // Spacing after the button
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
