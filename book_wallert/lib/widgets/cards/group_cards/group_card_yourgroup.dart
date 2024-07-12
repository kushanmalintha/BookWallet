import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_body.dart';
import 'package:flutter/material.dart';
import '../../../../../colors.dart';

class FandomCard extends StatelessWidget {
  final String groupName;
  final String memberCount;
  final int discussionCount;

  const FandomCard({
    super.key,
    required this.groupName,
    required this.memberCount,
    required this.discussionCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (changeGroupsScreenGlobal != null) {
          changeGroupsScreenGlobal!(const GroupProfileScreenBody());
        }
      },
      child: Card(
        color: MyColors.panelColor,
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'images/groupImage1.jpg', // Replace with actual image URL
                ),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: const TextStyle(
                        color: MyColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Members: 23,455',
                          style: TextStyle(color: MyColors.text2Color),
                        ),
                        Text(
                          'Discussions: 23,455',
                          style: TextStyle(color: MyColors.text2Color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
