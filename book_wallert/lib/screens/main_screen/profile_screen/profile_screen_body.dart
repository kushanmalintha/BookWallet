import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.bgColor,
      // appBar: AppBar(
      //   title: const Text('Profile'),
      // ),
      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(color: MyColors.text2Color),
        ),
      ),
    );
  }
}
