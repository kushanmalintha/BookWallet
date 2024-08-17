import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:book_wallert/controllers/user_follow_controller.dart';

const String location = 'Colombo, Sri Lanka';
const String workplace = 'Bookworm Inc.';
const String education = 'University of Peradeniya';
const String interests = 'Reading, Writing, Book Discussions';
const double avatarRadius = 40;
const double paddingValue = 16;
const double spacingValue = 8;
const double headerFontSize = 20;

class UserProfileDetails extends StatefulWidget {
  final User user;

  const UserProfileDetails({super.key, required this.user});

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
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
      showConfirmationDialog(
        context: context,
        title: 'Unfollow Confirmation',
        content: 'Are you sure you want to unfollow ${widget.user.username}?',
        confirmText: 'Unfollow',
        cancelText: 'Cancel',
        onConfirm: () async {
          final success = await UserfollowController.unfollowUser(
              globalUser!.userId, widget.user.userId);
          if (success) {
            setState(() {
              _isFollowing = false;
            });
          } else {
            print('Failed to unfollow user');
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            color: MyColors.bgColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: MyColors.nonSelectedItemColor,
                      backgroundImage: NetworkImage(widget.user.imageUrl),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.username,
                          style: const TextStyle(
                              color: MyColors.textColor, fontSize: 20),
                        ),
                        CustomToggleButton1(
                          isSelected: _isFollowing,
                          beforeText: 'Follow',
                          afterText: 'Following',
                          press: _isFollowing ? _unfollowUser : _followUser,
                          horizontalSpace: 18,
                          verticalalSpace: 6,
                          textColorSelected: MyColors.bgColor,
                          textColorNotSelected: MyColors.bgColor,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.user.description,
                  style: const TextStyle(color: MyColors.textColor),
                  textAlign: TextAlign.start,
                ),
                const BioDetails(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 10,
          child: CustomPopupMenuButtons(
            items: const ['Share', 'Block', 'Report'],
            onItemTap: [
              () => print("Share"),
              () => print("Block"),
              () => print("Report"),
            ],
            icon: const Icon(
              Icons.more_vert_rounded,
              color: MyColors.nonSelectedItemColor,
            ),
          ),
        ),
      ],
    );
  }
}

class BioDetails extends StatelessWidget {
  const BioDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.home, color: MyColors.textColor),
            SizedBox(width: 8),
            Text(
              'Lives in',
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(location, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.work, color: MyColors.textColor),
            SizedBox(width: 8),
            Text(
              'Works at',
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(workplace, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.school, color: MyColors.textColor),
            SizedBox(width: 8),
            Text(
              'Studied at',
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(education, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.favorite, color: MyColors.textColor),
            SizedBox(width: 8),
            Text(
              'Interested in',
              style: TextStyle(
                  color: MyColors.textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(interests, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
      ],
    );
  }
}
