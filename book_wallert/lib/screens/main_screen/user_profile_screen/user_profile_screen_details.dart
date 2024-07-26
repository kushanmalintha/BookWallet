import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';

// Constants
const String firstName = 'Kumarathunga';
const String lastName = 'Munidasa';
const String profileImagePath = 'images/groupImage1.jpg';
const String bioText =
    'I am an avid reader and book collector with a passion for fiction, historical novels, and fantasy. '
    'I am always on the lookout for the next great read and love diving into different worlds through books. '
    'When I am not reading, I enjoy discussing literature and sharing recommendations. '
    'Let us connect and explore our favorite stories together!';

const String location = 'Colombo, Sri Lanka';
const String workplace = 'Bookworm Inc.';
const String education = 'University of Peradeniya';
const String interests = 'Reading, Writing, Book Discussions';
const double avatarRadius = 40;
const double paddingValue = 16;
const double spacingValue = 8;
const double headerFontSize = 20;

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

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
                const CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: MyColors.nonSelectedItemColor,
                  backgroundImage: AssetImage(profileImagePath),
                ),
                const SizedBox(width: spacingValue),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '$firstName $lastName',
                      style: TextStyle(
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
            const Text(
              bioText,
              style: TextStyle(color: MyColors.textColor),
              textAlign: TextAlign.start,
            ),
            const BioDetails(), // Added the BioDetails widget here
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
              // Item actions
              () {
                print("i love Share");
              },
              () {
                print("i love Block");
              },
              () {
                print("i love Report");
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
