import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:flutter/material.dart';

class SharedByCard extends StatefulWidget {
  final Widget child;
  final List<String> sharedBy;
  final String imagePath;
  final int userId; // Assuming you have the userId for the sharedBy user

  const SharedByCard({
    super.key,
    required this.child,
    required this.sharedBy,
    required this.imagePath,
    required this.userId, // Add userId parameter
  });

  @override
  _SharedByCardState createState() => _SharedByCardState();
}

class _SharedByCardState extends State<SharedByCard> {
  void screenChange(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: MyColors.panelColor, // Card background color
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget passed as the child
            widget.child,

            Container(
                height: 1, // Height of the divider line
                color:
                    MyColors.nonSelectedItemColor, // Color of the divider line
                margin: const EdgeInsets.only(
                    bottom: 8) // Margin around the divider line
                ),

            GestureDetector(
              onTap: () => {
                screenChange(
                  context,
                  UserProfileScreenBody(userId: widget.userId),
                ),
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      widget.imagePath, // Use imagePath for the sharedBy user
                    ),
                    radius: 10,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'Shared by ',
                    style: const TextStyle(
                      color: MyColors.text2Color,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    widget.sharedBy.join(', '),
                    style: const TextStyle(
                      color: MyColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
