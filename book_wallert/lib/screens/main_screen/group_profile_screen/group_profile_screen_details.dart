import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Import your GroupModel class

class GroupProfileScreenDetails extends StatelessWidget {
  final GroupModel group;

  const GroupProfileScreenDetails({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      color: MyColors.bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(
                group.imageUrl), // Use the imageUrl from the GroupModel object
            radius: 70,
          ),
          Text(
            group.name, // Use the name from the GroupModel object
            style: const TextStyle(
              color: MyColors.textColor,
              fontSize: 20,
            ),
          ),
          Text(
            '${group.about}', // Use the about from the GroupModel object
            style: const TextStyle(
              color: MyColors.textColor,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 150,
            child: CustomToggleButton(
              beforeText: 'Send Request',
              afterText: 'Requested',
              verticalalSpace: 10,
              horizontalSpace: 10,
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
