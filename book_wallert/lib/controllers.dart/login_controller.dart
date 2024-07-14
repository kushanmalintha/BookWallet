import 'package:flutter/material.dart';
import 'package:book_wallert/services/api_services.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  Future<void> login(BuildContext context) async {
    try {
      String token = await apiService.signIn(
        usernameController.text,
        passwordController.text,
      );
      print('Token: $token');
      Navigator.pushNamed(context, '/MainScreen');
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to log in')),
      );
    }
  }
}
