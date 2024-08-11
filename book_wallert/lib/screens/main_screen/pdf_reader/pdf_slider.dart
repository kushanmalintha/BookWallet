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
        inactiveColor: const Color.fromARGB(219, 130, 131, 130),
        activeColor: const Color.fromARGB(219, 39, 173, 77),
        thumbColor: const Color.fromARGB(219, 39, 173, 77),
        value: sliderValue,
        min: 0,
        max: 100,
        onChanged: onChanged,
      ),
    );
  }
}
