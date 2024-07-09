import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
//import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/test_screens/screen3/screen3bodydart.dart';

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

// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: MyColors.bgColor,
//         padding: const EdgeInsets.all(16),
//         child: const Column(
//           children: [
//             SizedBox(height: 60), // Added height to move everything down
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: MyColors.nonSelectedItemColor,
//                   backgroundImage: AssetImage('images/groupImage1.jpg'),
//                 ),
//                 SizedBox(width: 16),
//                 Text(
//                   'Kumarathunga Munidasa',
//                   style: TextStyle(color: MyColors.textColor, fontSize: 20),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Text(
//               'I am an avid reader and book collector with a passion for fiction, historical novels, and fantasy. '
//               'I am always on the lookout for the next great read and love diving into different worlds through books. '
//               'When I am not reading, I enjoy discussing literature and sharing recommendations. '
//               'Let us connect and explore our favorite stories together!',
//               style: TextStyle(color: MyColors.textColor),
//               textAlign: TextAlign.justify,
//             ),
//             SizedBox(height: 1),
//             Expanded(
//               child: ProfileScreenBody(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.bgColor,
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            SizedBox(height: 60), // Added height to move everything down
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: MyColors.nonSelectedItemColor,
                  backgroundImage: AssetImage('images/groupImage1.jpg'),
                ),
                SizedBox(width: 16),
                Text(
                  'Kumarathunga Munidasa',
                  style: TextStyle(color: MyColors.textColor, fontSize: 20),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            Text(
              'I am an avid reader and book collector with a passion for fiction, historical novels, and fantasy. '
              'I am always on the lookout for the next great read and love diving into different worlds through books. '
              'When I am not reading, I enjoy discussing literature and sharing recommendations. '
              'Let us connect and explore our favorite stories together!',
              style: TextStyle(color: MyColors.textColor),
              textAlign: TextAlign.justify,
            ),
            //const SizedBox(height: 16), // Adjusted size for better spacing
            BioDetails(), // Added the BioDetails widget here
            // const SizedBox(height: 16), // Adjusted size for better spacing
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
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.home, color: MyColors.textColor),
            SizedBox(width: 8),
            Text('Lives in',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('Colombo, Sri Lanka',
                style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.work, color: MyColors.textColor),
            SizedBox(width: 8),
            Text('Works at',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('Bookworm Inc.', style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.school, color: MyColors.textColor),
            SizedBox(width: 8),
            Text('Studied at',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('University of Peradeniya',
                style: TextStyle(color: MyColors.textColor)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.favorite, color: MyColors.textColor),
            SizedBox(width: 8),
            Text('Interested in',
                style: TextStyle(
                    color: MyColors.textColor, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('Reading, Writing, Book Discussions',
                style: TextStyle(color: MyColors.textColor)),
          ],
        ),
      ],
    );
  }
}

class Review {
  final String firstName;
  final String lastName;
  final String bioText;
  final String worksAt;
  final String studiedAt;
  final double interestedIn;

  Review({
    required this.firstName,
    required this.lastName,
    required this.bioText,
    required this.worksAt,
    required this.studiedAt,
    required this.interestedIn,
  });
}
