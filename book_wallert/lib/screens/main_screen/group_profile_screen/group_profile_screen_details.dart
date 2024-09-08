import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';

class GroupProfileScreenDetails extends StatelessWidget {
  final GroupModel group;

  const GroupProfileScreenDetails({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            height: 290,
            color: MyColors.bgColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(group
                      .imageUrl), // Use the imageUrl from the GroupModel object
                  radius: 70,
                ),
                const SizedBox(height: 10), // Space between image and name
                Text(
                  group.name, // Use the name from the GroupModel object
                  style: const TextStyle(
                    color: MyColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center, // Center the group name
                ),
                const SizedBox(height: 8), // Space between name and about
                Text(
                  group.about, // Use the about from the GroupModel object
                  style: const TextStyle(
                    color: MyColors.textColor,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center, // Center the about text
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 1,
            child: CustomPopupMenuButtons(
              items: const ['Group info', 'Search', 'Report'],
              onItemTap: [
                () {
                  print("Group info");
                },
                () {
                  print("Search");
                },
                () {
                  print("Report");
                },
              ],
              icon: const Icon(
                Icons.more_vert_rounded,
                color: MyColors.nonSelectedItemColor,
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            right: 10,
            child: SizedBox(
              width: 120,
              child: CustomToggleButton(
                isSelected: false,
                beforeText: 'Send Request',
                afterText: 'Requested',
                verticalalSpace: 5,
                horizontalSpace: 6,
                textSize: 15,
                press: () {
                  // button function
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
