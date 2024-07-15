import 'package:flutter/material.dart';
import 'package:book_wallert/screens/login_screens/signup_screen.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:book_wallert/controllers/login_controller.dart';

// LoginScreen widget to handle user login UI and interaction
class LoginScreen extends StatelessWidget {
  // Instance of LoginController to manage login logic
  final LoginController loginController = LoginController();

  // Constructor
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
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
              // CustomTextBox for email input
              CustomTextBox(
                hintText: "Email",
                type: TextInputType.emailAddress,
                controller: loginController.emailController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              // CustomTextBox for password input
              CustomTextBox(
                hintText: "Password",
                type: TextInputType.visiblePassword,
                isPassword: true,
                controller: loginController.passwordController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              // CustomButton1 for login action
              CustomButton1(
                text: "Login",
                press: () => {
                  loginController.login(context),
                  Navigator.pushNamed(context, '/MainScreen')
                },
              ),
              const SizedBox(height: 10), // Add some space between widgets
              // GestureDetector for "Forgot password" action
              GestureDetector(
                onTap: () {
                  // Forgot password function
                  print("Forgot password?\nTry to Remember!!");
                },
                child: const Text(
                  "I forgot my password",
                  style: TextStyle(color: MyColors.textColor, fontSize: 12),
                ),
              ),
              const SizedBox(height: 10), // Add some space between widgets
              // GestureDetector for navigation to the signup screen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style:
                            TextStyle(color: MyColors.textColor, fontSize: 12),
                      ),
                      TextSpan(
                        text: "SIGN UP",
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
      ),
    );
  }
}
