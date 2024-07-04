import 'package:flutter/material.dart';

// A custom button widget with round edges
class CustomToggleButton extends StatefulWidget {
  // Text to be displayed on the button
  final String text;

  // Function to be called when the button is pressed
  final Function press;

  // Background color of the button when selected
  final Color backgroundColorSelected;

  // Background color of the button when not selected
  final Color backgroundColorNotSelected;

  // Text color of the button when selected
  final Color textColorSelected;

  // Text color of the button when not selected
  final Color textColorNotSelected;

  // Border color of the button
  final Color borderColor;

  // Constructor for initializing the custom button
  const CustomToggleButton({
    super.key,
    required this.text,
    required this.press,
    required this.backgroundColorSelected,
    required this.backgroundColorNotSelected,
    required this.textColorSelected,
    required this.textColorNotSelected,
    required this.borderColor,
  });

  @override
  // Creates state for the custom toggle button
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  // State variable to track if the button is selected or not
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Update the state to toggle selection and call the press function
        setState(() {
          isSelected = !isSelected;
        });
        widget.press(); // Call the function provided in the press parameter
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: BoxDecoration(
          color: isSelected
              ? widget.backgroundColorSelected
              : widget.backgroundColorNotSelected,
          borderRadius: BorderRadius.circular(200), // Circular border radius
          border: Border.all(
              color: widget.borderColor, width: 1.5), // Border styling
        ),
        child: Text(
          widget.text, // Display text on the button
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? widget.textColorSelected
                : widget.textColorNotSelected,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
