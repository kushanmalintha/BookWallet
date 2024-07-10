import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
//import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/test_screens/screen3/screen3bodydart.dart';

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

class Screen3 extends StatelessWidget {
  const Screen3({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileHeader(),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.bgColor,
        padding: const EdgeInsets.all(paddingValue),
        child: const Column(
          children: [
            SizedBox(height: 60), // Added height to move everything down
            Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: MyColors.nonSelectedItemColor,
                  backgroundImage: AssetImage(profileImagePath),
                ),
                SizedBox(width: spacingValue),
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                      color: MyColors.textColor, fontSize: headerFontSize),
                ),
              ],
            ),
            SizedBox(height: spacingValue),
            Text(
              bioText,
              style: TextStyle(color: MyColors.textColor),
              textAlign: TextAlign.justify,
            ),
            BioDetails(), // Added the BioDetails widget here
            Expanded(
              child: ProfileScreenBody(),
            ),
          ],
        ),
      ),
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

// class Review {
//   final String firstName;
//   final String lastName;
//   final String bioText;
//   final String worksAt;
//   final String studiedAt;
//   final String interestedIn;

//   Review({
//     required this.firstName,
//     required this.lastName,
//     required this.bioText,
//     required this.worksAt,
//     required this.studiedAt,
//     required this.interestedIn,
//   });
// }
