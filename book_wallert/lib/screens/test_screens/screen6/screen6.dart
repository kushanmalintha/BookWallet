// group_card_base.dart
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_button.dart';

class Screen6 extends StatelessWidget {
  final GroupModel group;
  final Widget? leading; // Optional leading widget
  final Widget? central; // Optional central widget
  final Widget? bottom; // Optional bottom widget

  const Screen6({
    super.key,
    required this.group,
    this.leading,
    this.central,
    this.bottom,
    required User,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to GroupProfileScreenBody when the card is tapped
        screenChange(context, const GroupProfileScreenBody());
      },
      child: Card(
        color: MyColors.panelColor, // Card background color
        margin: const EdgeInsets.all(5), // Margin around the card
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align items at the start horizontally
            children: [
              Row(
                children: [
                  if (leading != null)
                    leading!, // If leading is provided, display it
                  const SizedBox(
                      width: 10), // Add space between leading and avatar
                  // CircleAvatar widget to display the group image
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      group.imageUrl, // Use imageUrl from the group object
                    ),
                    radius: 25,
                  ),
                  const SizedBox(
                      width: 10), // Add space between avatar and text
                  if (central != null) ...[
                    central!, // If central is provided, display it
                    const SizedBox(
                        width: 10), // Add space between central widget and text
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align text at the start horizontally
                      children: [
                        // Display the group name
                        Text(
                          group.name,
                          style: const TextStyle(
                            color: MyColors.textColor, // Text color
                            fontSize: 16, // Font size
                            fontWeight: FontWeight.bold, // Bold font weight
                          ),
                        ),
                        const SizedBox(height: 5), // Add space between texts
                        // Display member count and discussion count in a row
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between texts
                          children: [
                            Text(
                              'Members: ${group.memberCount}', // Use memberCount from the group object
                              style:
                                  const TextStyle(color: MyColors.text2Color),
                            ),
                            Text(
                              'Discussions: ${group.discussionCount}', // Use discussionCount from the group object
                              style:
                                  const TextStyle(color: MyColors.text2Color),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4), // Add space at the bottom
                        Row(
                          children: [
                            CustomToggleButton(
                              beforeText:
                                  'Send Request', // Button text before toggle
                              afterText:
                                  'Requested', // Button text after toggle
                              press: () {
                                // Add your onPressed functionality here
                              },
                              verticalalSpace:
                                  10, // Vertical space around the button text
                              horizontalSpace:
                                  15, // Horizontal space around the button text
                              textSize: 12, // Button text size
                            ),
                            const SizedBox(width: 15),
                            if (bottom !=
                                null) // Optional divider to separate the bottom widget
                              bottom!,
                            const Expanded(
                              child: Text(
                                'Suggested By: Ravindu Pathirage and ...',
                                style: TextStyle(
                                    color: MyColors.text2Color, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ), // Add space between buttons
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // If bottom is provided, display it
            ],
          ),
        ),
      ),
    );
  }
}
