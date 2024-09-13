import 'package:book_wallert/colors.dart'; // Custom color class for the app
import 'package:book_wallert/functions/global_navigator_functions.dart'; // Function for screen navigation
import 'package:book_wallert/functions/global_user_provider.dart'; // Provides global user details
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart'; // User profile screen UI
import 'package:book_wallert/widgets/buttons/custom_button.dart'; // Custom button widget
import 'package:flutter/material.dart';
import 'package:book_wallert/models/user.dart'; // User model
import 'package:book_wallert/controllers/user_follow_controller.dart'; // Controller to manage follow/unfollow actions

class UserReqCard extends StatefulWidget {
  final User user; // User object to display in the card

  const UserReqCard(
      {super.key,
      required this.user}); // Requires a User object for this widget

  @override
  _UserReqCardState createState() => _UserReqCardState();
}

class _UserReqCardState extends State<UserReqCard> {
  bool _isFollowing =
      false; // Tracks whether the current user is following the user in this card

  @override
  void initState() {
    super.initState();
    _checkFollowStatus(); // Check the follow status when the widget is initialized
  }

  // Function to check if the global user is following the user in this card
  Future<void> _checkFollowStatus() async {
    try {
      // Fetch follow status from the controller
      bool following = await UserFollowController.checkFollowStatus(
          globalUser?.userId ?? 0, widget.user.userId);
      setState(() {
        _isFollowing = following; // Update the follow status
      });
    } catch (e) {
      // Handle errors (e.g., network issues)
      print('Error checking follow status: $e');
    }
  }

  // Function to follow the user
  Future<void> _followUser() async {
    if (globalUser?.userId != null) {
      // Call the followUser function in the controller
      final success = await UserFollowController.followUser(
          globalUser!.userId, widget.user.userId);
      if (success) {
        setState(() {
          _isFollowing = true; // Update UI to reflect follow status
        });
      } else {
        // Handle error if following fails
        print('Failed to follow user');
      }
    }
  }

  // Function to unfollow the user
  Future<void> _unfollowUser() async {
    if (globalUser?.userId != null) {
      // Call the unfollowUser function in the controller
      final success = await UserFollowController.unfollowUser(
          globalUser!.userId, widget.user.userId);
      if (success) {
        setState(() {
          _isFollowing = false; // Update UI to reflect unfollow status
        });
      } else {
        // Handle error if unfollowing fails
        print('Failed to unfollow user');
      }
    }
  }

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
                    ));
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
            SizedBox(
              height: 30, // Button height
              width: 100, // Adjust button width if needed
              child: Align(
                alignment: Alignment.centerRight, // Align button to the right
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10), // Adjust padding to move the button left
                  child: CustomToggleButton(
                    isSelected: _isFollowing, // Toggle follow/unfollow status
                    beforeText: 'Accept', // Button text when not following
                    afterText: 'Remove', // Button text when following
                    press: _isFollowing
                        ? _unfollowUser
                        : _followUser, // Action when button is pressed
                    horizontalSpace:
                        7, // Horizontal padding for the button's text
                    verticalalSpace:
                        3, // Vertical padding for the button's text
                    textColorSelected: MyColors
                        .bgColor, // Text color when selected (following)
                    textColorNotSelected: MyColors
                        .bgColor, // Text color when not selected (not following)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
