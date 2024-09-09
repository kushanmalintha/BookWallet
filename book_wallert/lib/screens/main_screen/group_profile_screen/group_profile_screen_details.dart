import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_member_screen.dart';
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
            height: 320, // Increased height to accommodate the new button
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
          // Members button
          Positioned(
            bottom: 50, // Position above the "Send Request" button
            right: 10,
            child: SizedBox(
              width: 120, // Same width as the "Send Request" button
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to another screen (MembersScreen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupMembersScreenBody(
                              groupId: group.group_id,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.panelColor,
                ),
                child: const Text(
                  'Members',
                  style: TextStyle(color: MyColors.textColor),
                ),
              ),
            ),
          ),
          // Send Request button
          Positioned(
            bottom: 1, // Position at the bottom
            right: 10,
            child: SizedBox(
              width: 120, // Width of the button
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

// MembersScreen for navigation
class MembersScreen extends StatelessWidget {
  final int groupId;

  const MembersScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Members'),
      ),
      body: Center(
        child: Text('Displaying members for group: $groupId'),
      ),
    );
  }
}
