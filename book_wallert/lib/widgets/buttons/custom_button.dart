import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// A custom button widget with round edges
// ignore: must_be_immutable
class CustomToggleButton extends StatefulWidget {
  // Text to be displayed on the button
  final String beforeText;
  final String afterText;

  // Function to be called when the button is pressed
  final Function press;

  // Background color of the button when selected
  Color backgroundColorSelected;

  // Background color of the button when not selected
  Color backgroundColorNotSelected;

  // Text color of the button when selected
  Color textColorSelected;

  // Text color of the button when not selected
  Color textColorNotSelected;

  // Border color of the button
  Color borderColor;

  // Horizontal space
  final double horizontalSpace;

  // Vertical space
  final double verticalalSpace;

  // Font size
  final double textSize;
  // State variable to track if the button is selected or not
  bool isSelected = false;
  // Constructor for initializing the custom button
  CustomToggleButton({
    super.key,
    required this.beforeText,
    required this.afterText,
    required this.press,
    required this.isSelected,
    this.backgroundColorSelected = MyColors.selectedItemColor,
    this.backgroundColorNotSelected = MyColors.nonSelectedItemColor,
    this.textColorSelected = MyColors.bgColor,
    this.textColorNotSelected = MyColors.bgColor,
    this.borderColor = MyColors.nonSelectedItemColor,
    this.horizontalSpace = 40,
    this.verticalalSpace = 20,
    this.textSize = 15,
  });

  @override
  // Creates state for the custom toggle button
  // ignore: library_private_types_in_public_api
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Update the state to toggle selection and call the press function
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.press(); // Call the function provided in the press parameter
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: widget.verticalalSpace,
            horizontal: widget.horizontalSpace),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.backgroundColorNotSelected
              : widget.backgroundColorSelected,
          borderRadius: BorderRadius.circular(200), // Circular border radius
          border: Border.all(
              color: widget.borderColor, width: 1.5), // Border styling
        ),
        child: Center(
          child: Text(
            widget.isSelected
                ? widget.afterText
                : widget.beforeText, // Display text on the button
            style: TextStyle(
              fontSize: widget.textSize,
              color: widget.isSelected
                  ? widget
                      .textColorSelected // Use selected text color when isSelected is true
                  : widget
                      .textColorNotSelected, // Use not selected text color when isSelected is false
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
