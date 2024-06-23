import 'package:flutter/material.dart';

// A custom button widget with round edges
class RoundButton extends StatelessWidget {
  // Text to be displayed on the button
  final String text;

  // Function to be called when the button is pressed
  final Function press;

  // Background color of the button
  final Color backgrounColor;

  // Foreground color of the button (usually the text color)
  final Color foregroundColor;

  // Constructor to initialize the button properties
  const RoundButton({
    super.key,
    required this.text,
    required this.press,
    required this.backgrounColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Define the button's style
      style: TextButton.styleFrom(
        // Padding inside the button
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
        // Background color of the button
        backgroundColor: backgrounColor,
        // Foreground color of the button (usually the text color)
        foregroundColor: foregroundColor,
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
