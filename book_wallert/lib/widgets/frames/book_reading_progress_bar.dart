import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class BookReadingProgressBar extends StatelessWidget {
  final Widget child;
  final double progress; // Value between 0 and 1

  const BookReadingProgressBar(
      {super.key, required this.child, required this.progress})
      : assert(progress >= 0 && progress <= 1);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: child,
          ),
          Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Colors.grey[300],
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: progress == 1.0
                        ? const Radius.circular(10.0)
                        : Radius.zero,
                  ),
                  color: MyColors.selectedItemColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
