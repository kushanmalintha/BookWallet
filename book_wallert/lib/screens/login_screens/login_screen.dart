// login_screen.dart

import 'package:flutter/material.dart';
import 'package:book_wallert/controllers.dart/login_controller.dart';
import 'package:book_wallert/screens/login_screens/signup_screen.dart';
import 'package:book_wallert/textbox/custom_textbox.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = LoginController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                controller: _loginController.usernameController,
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "Password",
                type: TextInputType.visiblePassword,
                isPassword: true,
                controller: _loginController.passwordController,
              ),
              const SizedBox(height: 10),
              CustomButton1(
                text: "Login",
                press: () => _loginController.login(context),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Forgot password function
                  print("Forgot password");
                },
                child: const Text(
                  "I forgot my password",
                  style: TextStyle(color: MyColors.textColor, fontSize: 12),
                ),
              ),
              const SizedBox(height: 10),
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
