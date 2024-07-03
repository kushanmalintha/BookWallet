import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class Screen5 extends StatelessWidget {
  const Screen5({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Text(
          'a test screen',
          style: TextStyle(color: MyColors.text2Color),
        ),
      ),
    );
  }
}
