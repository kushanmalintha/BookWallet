import 'package:book_wallert/colors.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:flutter/material.dart';

class ReactUserCard extends StatelessWidget {
  const ReactUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: MyColors.panelColor,
        child: Row(
          children: [
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                screenChange(
                    context,
                    UserProfileScreenBody(
                      userId: dummyUser.userId,
                    ));
              },
              child: const Text(
                'User',
                style: TextStyle(color: MyColors.textColor, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
