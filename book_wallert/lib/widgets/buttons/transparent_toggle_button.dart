import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleFollow,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Transparent background
        disabledForegroundColor: Colors.transparent.withOpacity(0.38),
        disabledBackgroundColor:
            Colors.transparent.withOpacity(0.12), // Transparent when disabled
        shadowColor: Colors.transparent, // Transparent shadow
        side: BorderSide(
          color: isFollowing
              ? MyColors.nonSelectedItemColor
              : MyColors.selectedItemColor,
        ),
      ),
      child: Text(
        isFollowing ? 'Following' : 'Follow',
        style: TextStyle(
          color: isFollowing
              ? MyColors.nonSelectedItemColor
              : MyColors.selectedItemColor,
        ),
      ),
    );
  }
}
