import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart'; // Import your GroupModel class

class GroupProfileScreenDetails extends StatelessWidget {
  final GroupModel group;

  const GroupProfileScreenDetails({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: MyColors.bgColor,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: AssetImage(group
                  .imageUrl), // Use the imageUrl from the GroupModel object
              radius: 60,
            ),
          ),
          Positioned(
            top: 10,
            left: 150,
            child: Text(
              group.name, // Use the name from the GroupModel object
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 150,
            right: 15,
            child: Text(
              'About: ${group.about}', // Use the about from the GroupModel object
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Positioned(
            top: 100,
            left: 150,
            right: 100,
            child: CustomToggleButton(
              beforeText: 'Send Request',
              afterText: 'Requested',
              verticalalSpace: 10,
              horizontalSpace: 0,
              textSize: 15,
              press: () {
                // button function
              },
            ),
          ),
        ],
      ),
    );
  }
}
