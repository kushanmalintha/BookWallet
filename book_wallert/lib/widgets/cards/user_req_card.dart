import 'package:book_wallert/controllers/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/user.dart'; // User model
import 'package:book_wallert/colors.dart'; // Custom color class for the app
import 'package:book_wallert/functions/global_navigator_functions.dart'; // Function for screen navigation
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart'; // User profile screen UI

class UserReqCard extends StatefulWidget {
  final User user; // User object to display in the card
  final group_id;
  const UserReqCard(
      {super.key,
      required this.user,
      required this.group_id}); // Requires a User object for this widget

  @override
  _UserReqCardState createState() => _UserReqCardState();
}

class _UserReqCardState extends State<UserReqCard> {
  final GroupController _groupController = GroupController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70, // Fixed height for the card
      child: Card(
        color: MyColors.panelColor, // Custom background color for the card
        child: Row(
          children: [
            const SizedBox(width: 10), // Space between card border and avatar
            GestureDetector(
              onTap: () {
                // Navigate to the user's profile screen when the avatar is tapped
                screenChange(
                  context,
                  UserProfileScreenBody(
                    userId: widget
                        .user.userId, // Pass the userId to the profile screen
                  ),
                );
              },
              child: CircleAvatar(
                radius: 21, // Set the size of the user's profile image
                backgroundImage: NetworkImage(widget
                    .user.imageUrl), // Load user's profile image from network
              ),
            ),
            const SizedBox(width: 10), // Space between avatar and username
            Expanded(
              child: Text(
                widget.user.username, // Display the username
                style: const TextStyle(color: MyColors.textColor, fontSize: 15),
              ),
            ),
            Row(
              children: [
                // Accept Button
                SizedBox(
                  height: 30, // Button height
                  width: 65, // Adjust button width if needed
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Assuming you have a way to get the groupId
                        await _groupController.acceptRequest(
                            widget.group_id, widget.user.userId);
                        print('Accepted ${widget.user.username}');
                      } catch (e) {
                        print('Error accepting request: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          MyColors.selectedItemColor, // Button background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                // Remove Button
                SizedBox(
                  height: 30, // Button height
                  width: 65, // Adjust button width if needed
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Assuming you have a way to get the groupId
                        await _groupController.removeRequest(
                            widget.group_id, widget.user.userId);
                        print('Removed ${widget.user.username}');
                      } catch (e) {
                        print('Error removing request: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          MyColors.bgColor, // Button background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(
                    width: 10), // Space between buttons and the right border
              ],
            ),
          ],
        ),
      ),
    );
  }
}
