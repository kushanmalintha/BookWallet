import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class SharedByCard extends StatelessWidget {
  final Widget child;
  final List<String> sharedBy;
  final String imagePath;
  // final Color cardColor;

  const SharedByCard({
    super.key,
    required this.child,
    required this.sharedBy,
    required this.imagePath,
    // required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor, // Card background color
      margin: const EdgeInsets.all(8), // Margin around the card
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget passed as the child
            child,

            Container(
              height: 1, // Height of the divider line
              color: Colors.grey[400], // Color of the divider line
              margin: const EdgeInsets.symmetric(
                  vertical: 10), // Margin around the divider line
            ),

            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    imagePath, // Use imagePath for the sharedBy user
                  ),
                  radius: 10,
                ),
                const SizedBox(width: 10),
                Text(
                  'Shared by $sharedBy',
                  style: const TextStyle(
                    color: MyColors.textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
