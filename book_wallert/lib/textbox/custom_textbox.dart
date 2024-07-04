import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A custom text box widget
class CustomTextBox extends StatelessWidget {
  // Hint text to be displayed inside the text box
  final String hintText;
  // Keyboard type for the text box (e.g., text, number, email, etc.)
  final TextInputType type;

  // Constructor to initialize hintText and type
  const CustomTextBox({
    super.key,
    required this.hintText,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the height of the text box
      height: 50,
      // Set the width of the text box
      width: 350,
      // Decoration for inputs
      child: TextField(
        style: const TextStyle(
          color: MyColors.titleColor,
        ),
        // Set the keyboard type for the text box
        keyboardType: type,
        // Define the decoration for the text box
        decoration: InputDecoration(
          // Set the border style for the text box
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.text2Color),
          ),
          // Set the hint text to be displayed inside the text box
          hintText: hintText,
          hintStyle: const TextStyle(
            color: MyColors.text2Color,
          ),
        ),
      ),
    );
  }
}
