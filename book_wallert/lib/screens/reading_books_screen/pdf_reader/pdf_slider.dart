import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class PDFSlider extends StatelessWidget {
  final double sliderValue;
  final ValueChanged<double> onChanged;

  const PDFSlider({
    super.key,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Slider(
        inactiveColor: MyColors.nonSelectedItemColor,
        activeColor: MyColors.selectedItemColor,
        thumbColor: MyColors.selectedItemColor,
        value: sliderValue,
        min: 0,
        max: 100,
        onChanged: onChanged,
      ),
    );
  }
}
