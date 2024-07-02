import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class CustomToggleButton extends StatefulWidget {
  final String text;
  // Started from 3 so if created new one (first) index will be 0 and the add to it.
  static int index = 3;

  const CustomToggleButton({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    // CustomToggleButton.index = (CustomToggleButton.index + 1) % 4;
    // int myIndex = CustomToggleButton.index; // for future usage
    print(CustomToggleButton.index);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.selectedItemColor : MyColors.bgColor,
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: MyColors.textColor, width: 1.5),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? MyColors.bgColor : MyColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
