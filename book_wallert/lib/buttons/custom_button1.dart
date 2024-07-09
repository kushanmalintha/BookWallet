import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A custom button widget with round edges
class CustomButton1 extends StatelessWidget {
  // Text to be displayed on the button
  final String text;

  // Function to be called when the button is pressed
  final Function press;

  // Background color of the button
  final Color backgroundColor;

  // Text color of the button
  final Color textColor;

  // Border color of the button
  final Color borderColor;

  // Constructor to initialize the button properties
  const CustomButton1({
    super.key,
    required this.text,
    required this.press,
    this.backgroundColor = MyColors.selectedItemColor,
    this.textColor = MyColors.textColor,
    this.borderColor = MyColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Define the button's style
      style: TextButton.styleFrom(
        // Padding inside the button
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        // Background color of the button
        backgroundColor: backgroundColor,
        // border color of the button
        side: BorderSide(color: borderColor),
        // Text color of the button
        foregroundColor: textColor,
      ),
      // Define the function to be called when the button is pressed
      onPressed: () => press(),
      // Define the child widget (text) of the button
      child: Text(
        text,
        style: const TextStyle(
          // Font size of the text
          fontSize: 18,
        ),
      ),
    );
  }
}
