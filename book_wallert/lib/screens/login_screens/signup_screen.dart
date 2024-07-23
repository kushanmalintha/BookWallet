import 'package:book_wallert/controllers/signup_controller.dart';
import 'package:book_wallert/textbox/custom_textbox1.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/login_screens/login_screen.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:book_wallert/colors.dart';

// SignupScreen widget to handle user signup UI and interaction
class SignupScreen extends StatelessWidget {
  // Instance of SignupController to manage signup logic
  final SignupController _signupController = SignupController();

  // Constructor
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor, // Background color for the screen
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          children: <Widget>[
            // CircleAvatar widget to display the app logo
            const CircleAvatar(
              backgroundImage: AssetImage("images/Book_Image1.jpg"),
              radius: 60,
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // Welcome text
            const Text(
              "WELCOME TO BOOKWALLET",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: MyColors.textColor,
              ),
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // CustomTextBox for username input
            CustomTextBox1(
              lableText: "UserName",
              type: TextInputType.name,
              controller: _signupController.usernameController,
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // CustomTextBox for email input
            CustomTextBox1(
              lableText: "Email",
              type: TextInputType.emailAddress,
              controller: _signupController.emailController,
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // CustomTextBox for password input
            CustomTextBox1(
              lableText: "Password",
              type: TextInputType.visiblePassword,
              isPassword: true,
              controller: _signupController.passwordController,
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // CustomTextBox for confirm password input
            CustomTextBox1(
              lableText: "Confirm Password",
              type: TextInputType.visiblePassword,
              isPassword: true,
              controller: _signupController.confirmPasswordController,
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // CustomButton1 for signup action
            CustomButton1(
              text: "Sign up",
              press: () => _signupController.signUp(context),
            ),
            const SizedBox(height: 10), // Add some space between widgets
            // GestureDetector for navigation to the login screen
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
