import 'package:book_wallert/colors.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/controllers/user_follow_controller.dart'; // Ensure correct import

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
  }

  Future<void> _checkFollowStatus() async {
    try {
      bool following = await UserfollowController.checkFollowStatus(
          globalUser?.userId ?? 0, widget.user.userId);
      setState(() {
        _isFollowing = following;
      });
    } catch (e) {
      // Handle error
      print('Error checking follow status: $e');
    }
  }

  Future<void> _followUser() async {
    if (globalUser?.userId != null) {
      final success = await UserfollowController.followUser(
          globalUser!.userId, widget.user.userId);
      if (success) {
        setState(() {
          _isFollowing = true;
        });
      } else {
        // Handle error
        print('Failed to follow user');
      }
    }
  }

  Future<void> _unfollowUser() async {
    if (globalUser?.userId != null) {
      final success = await UserfollowController.unfollowUser(
          globalUser!.userId, widget.user.userId);
      if (success) {
        setState(() {
          _isFollowing = false;
        });
      } else {
        // Handle error
        print('Failed to unfollow user');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: MyColors.panelColor,
        child: Row(
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  widget.user.imageUrl), // Assuming User class has imageUrl
            ),
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                screenChange(
                    context,
                    UserProfileScreenBody(
                      userId:
                          widget.user.userId, // Access userId from User object
                    ));
              },
              child: Text(
                widget.user.username, // Assuming User class has a username
                style: const TextStyle(color: MyColors.textColor, fontSize: 15),
              ),
            ),
            const SizedBox(
              width: 100,
            ), // Pushes the button to the right side;
            SizedBox(
              height: 30,
              child: CustomToggleButton(
                isSelected: _isFollowing,
                beforeText: 'Follow',
                afterText: 'Following',
                press: _isFollowing ? _unfollowUser : _followUser,
                horizontalSpace: 18,
                verticalalSpace: 3,
                textColorSelected: MyColors.bgColor,
                textColorNotSelected: MyColors.bgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
