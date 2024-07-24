import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A custom text box widget
class CustomTextBox1 extends StatefulWidget {
  // Hint text to be displayed inside the text box
  final String lableText;
  // Keyboard type for the text box (e.g., text, number, email, etc.)
  final TextInputType type;
  // To make password invisible
  final bool isPassword;
  // TextEditingController for the text box
  final TextEditingController controller;

  // Constructor to initialize hintText, type, isPassword, and controller
  const CustomTextBox1({
    super.key,
    required this.lableText,
    required this.type,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextBox1> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox1> {
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
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.selectedItemColor)),
          labelText: widget.lableText,
          labelStyle: const TextStyle(color: MyColors.textColor),
          // Set the border style for the text box
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
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
