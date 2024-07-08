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
            SizedBox(height: 16),
            Text(
              'I am an avid reader and book collector with a passion for fiction, historical novels, and fantasy. '
              'I am always on the lookout for the next great read and love diving into different worlds through books. '
              'When I am not reading, I enjoy discussing literature and sharing recommendations. '
              'Let us connect and explore our favorite stories together!',
              style: TextStyle(color: MyColors.textColor),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 1),
            Expanded(
              child: ProfileScreenBody(),
            ),
          ],
        ),
      ),
    );
  }
}
