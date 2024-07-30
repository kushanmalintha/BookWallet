import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';

const String location = 'Colombo, Sri Lanka';
const String workplace = 'Bookworm Inc.';
const String education = 'University of Peradeniya';
const String interests = 'Reading, Writing, Book Discussions';
const double avatarRadius = 40;
const double paddingValue = 16;
const double spacingValue = 8;
const double headerFontSize = 20;

class UserProfileDetails extends StatelessWidget {
  final User user;
  //fetchUserById(int userId)   use this function to get details

  const UserProfileDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: Container(
        color: MyColors.bgColor,
        padding: const EdgeInsets.all(paddingValue),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: MyColors.nonSelectedItemColor,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(width: spacingValue),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                          color: MyColors.textColor, fontSize: headerFontSize),
                    ),
                    CustomToggleButton(
                      beforeText: 'Follow',
                      afterText: 'Following',
                      press: () {},
                      horizontalSpace: 18,
                      verticalalSpace: 6,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: spacingValue),
            Text(
              user.description,
              style: const TextStyle(color: MyColors.textColor),
              textAlign: TextAlign.start,
            ),
            const BioDetails(), // Updated the BioDetails widget here
          ],
        ),
      )),
      Positioned(
        top: 16,
        right: 10,
        child: CustomPopupMenuButtons(
            items: const [
              'Share',
              'Block',
              'Report',
            ],
            onItemTap: [
              () {
                print("Share");
              },
              () {
                print("Block");
              },
              () {
                print("Report");
              },
            ],
            icon: const Icon(
              Icons.more_vert_rounded,
              color: MyColors.nonSelectedItemColor,
            )),
      )
    ]);
  }
}

class BioDetails extends StatelessWidget {
  const BioDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spacingValue * 2),
        Row(
          children: [
            Icon(Icons.home, color: MyColors.textColor),
            SizedBox(width: spacingValue),
            Text('Lives in',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: spacingValue),
            Text(location, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: spacingValue),
        Row(
          children: [
            Icon(Icons.work, color: MyColors.textColor),
            SizedBox(width: spacingValue),
            Text('Works at',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: spacingValue),
            Text(workplace, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: spacingValue),
        Row(
          children: [
            Icon(Icons.school, color: MyColors.textColor),
            SizedBox(width: spacingValue),
            Text('Studied at',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: spacingValue),
            Text(education, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: spacingValue),
        Row(
          children: [
            Icon(Icons.favorite, color: MyColors.textColor),
            SizedBox(width: spacingValue),
            Text('Interested in',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: spacingValue),
            Text(interests, style: TextStyle(color: MyColors.textColor)),
          ],
        ),
      ],
    );
  }
}


