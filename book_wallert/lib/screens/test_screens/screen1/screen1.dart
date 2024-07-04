//import 'package:book_wallert/buttons/custom_button.dart';
import 'package:book_wallert/buttons/custom_button1.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/Book_Image1.jpg",
              width: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              "WELCOME TO BOOKWALLET",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: MyColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            /*CustomToggleButton(
              text: "Login",
              press: () {
                // add login function
              },
              backgroundColorSelected: MyColors.selectedItemColor,
              backgroundColorNotSelected: MyColors.nonSelectedItemColor,
              textColorSelected: MyColors.textColor,
              textColorNotSelected: MyColors.text2Color,
              borderColor: MyColors.text2Color,
            ),*/
            const CustomTextBox(
              hintText: "UserName",
              type: TextInputType.name,
            ),
            const SizedBox(height: 10),
            const CustomTextBox(
              hintText: "Password",
              type: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 10),
            CustomButton1(
              text: "Login",
              press: () {
                // Add login function here
              },
              backgroundColor: MyColors.selectedItemColor,
              textColor: MyColors.textColor,
              borderColor: MyColors.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
