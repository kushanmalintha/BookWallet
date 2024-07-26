import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/login_controller.dart';
import 'package:book_wallert/services/auth_api_services.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});
  final AuthApiService authService = AuthApiService();

  @override
  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    LoginController.loginWithToken(context);
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              "Loading, please wait...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
