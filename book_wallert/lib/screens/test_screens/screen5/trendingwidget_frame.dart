import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class RankedCard extends StatelessWidget {
  final int rank;
  final Widget child;

  const RankedCard({
    super.key,
    required this.rank,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      margin: const EdgeInsets.all(3), // Margin around the card
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items at the center vertically
        children: [
          // Frame with rank number
          Container(
            padding: const EdgeInsets.all(16.0),
            color: MyColors.panelColor, // Container background color
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontSize: 25, // Font size for the rank number
                  fontWeight: FontWeight.bold, // Bold font weight
                  color: Colors.white, // Text color for the rank number
                ),
              ),
            ),
          ),
          //const SizedBox(width: 2), // Space between rank number and card
          // Card widget
          Expanded(child: child),
        ],
      ),
    );
  }
}
