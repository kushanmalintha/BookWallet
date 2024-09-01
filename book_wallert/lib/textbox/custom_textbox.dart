import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A custom text box widget
class CustomTextBox extends StatefulWidget {
  // Hint text to be displayed inside the text box
  final String hintText;
  // Keyboard type for the text box (e.g., text, number, email, etc.)
  final TextInputType type;
  // To make password invisible
  final bool isPassword;
  // TextEditingController for the text box
  final TextEditingController controller;

  // Constructor to initialize hintText, type, isPassword, and controller
  const CustomTextBox({
    super.key,
    required this.hintText,
    required this.type,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextBox> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the height of the text box
      height: 50,
      // Set the width of the text box
      width: 350,
      // Decoration for inputs
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(
          color: MyColors.titleColor,
        ),
        // Define the decoration for the text box
        decoration: InputDecoration(
          // Set the border style for the text box
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.text2Color),
          ),
          // Set the hint text to be displayed inside the text box
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: MyColors.text2Color,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ),
        keyboardType: widget.type,
        obscureText: widget.isPassword ? _isObscured : false,
      ),
    );
  }
}
