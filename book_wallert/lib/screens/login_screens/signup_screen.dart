//import 'package:book_wallert/buttons/custom_button.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:book_wallert/screens/test_screens/screen1/screen1.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage(
                "images/Book_Image1.jpg",
              ),
              radius: 60,
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
            const CustomTextBox(
              hintText: "UserName",
              type: TextInputType.name,
            ),
            const SizedBox(height: 10),
            const CustomTextBox(
              hintText: "Email",
              type: TextInputType.name,
            ),
            const SizedBox(height: 10),
            const CustomTextBox(
              hintText: "Password",
              type: TextInputType.visiblePassword,
              // give isPassword false if it is not a password
              isPassword: true,
            ),
            const SizedBox(height: 10),
            const CustomTextBox(
              hintText: "Confirm Password",
              type: TextInputType.visiblePassword,
              // give isPassword false if it is not a password
              isPassword: true,
            ),
            const SizedBox(height: 10),
            CustomButton1(
              text: "Sign up",
              press: () {
                // Add login function here
              },
              //backgroundColor: MyColors.selectedItemColor,
              //textColor: MyColors.textColor,
              //borderColor: MyColors.textColor,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // go to the sign in page function
                //print("hello");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Screen1()),
                );
              },
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: MyColors.textColor, fontSize: 12),
                    ),
                    TextSpan(
                      text: "LOG IN",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
