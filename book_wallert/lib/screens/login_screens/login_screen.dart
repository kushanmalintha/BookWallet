//import 'package:book_wallert/buttons/custom_button.dart';
import 'package:book_wallert/buttons/custom_button1.dart';
import 'package:book_wallert/screens/login_screens/signup_screen.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
            /*CustomToggleButton(
              beforeText: "Send",
              afterText: "Requested",
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
              // give isPassword false if it is not a password
              isPassword: true,
            ),
            const SizedBox(height: 10),
            CustomButton1(
              text: "Login",
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
                // forgot password function
                print("hello");
              },
              child: const Text(
                "I forgot my password",
                style: TextStyle(color: MyColors.textColor, fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // go to the sign in page function
                //print("hello");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: MyColors.textColor, fontSize: 12),
                    ),
                    TextSpan(
                      text: "SIGN UP",
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
