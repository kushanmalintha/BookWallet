import 'package:flutter/material.dart';
import 'package:book_wallert/controllers.dart/signup_controller.dart';
import 'package:book_wallert/screens/login_screens/login_screen.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:book_wallert/colors.dart';

class SignupScreen extends StatelessWidget {
  final SignupController _signupController = SignupController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage("images/Book_Image1.jpg"),
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
            CustomTextBox(
              hintText: "Username",
              type: TextInputType.text, // Adjusted for username
              controller: _signupController.usernameController,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              hintText: "Email",
              type: TextInputType.emailAddress,
              controller: _signupController.emailController,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              hintText: "Password",
              type: TextInputType.visiblePassword,
              isPassword: true,
              controller: _signupController.passwordController,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              hintText: "Confirm Password",
              type: TextInputType.visiblePassword,
              isPassword: true,
              controller: _signupController.confirmPasswordController,
            ),
            const SizedBox(height: 10),
            CustomButton1(
              text: "Sign up",
              press: () => _signupController.signUp(context),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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
                        fontWeight: FontWeight.bold,
                      ),
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
