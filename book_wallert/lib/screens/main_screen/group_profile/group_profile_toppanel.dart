import 'package:book_wallert/buttons/custom_button.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class GroupProfileTopPanel extends StatelessWidget {
  const GroupProfileTopPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 160,
      width: screenWidth,
      color: MyColors.bgColor,
      child: Stack(
        children: [
          const Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: AssetImage("images/Book_Image1.jpg"),
              radius: 60,
            ),
          ),
          const Positioned(
            top: 10,
            left: 150,
            child: Text(
              "Harry Potter Fans",
              style: TextStyle(
                color: MyColors.textColor,
                fontSize: 20,
              ),
            ),
          ),
          const Positioned(
            top: 40,
            left: 150,
            right: 15,
            child: Text(
              "About: If you are a harry potter fan join us...",
              style: TextStyle(
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
