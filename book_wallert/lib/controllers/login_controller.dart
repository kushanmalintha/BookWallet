import 'package:flutter/material.dart';
import 'package:book_wallert/services/api_services.dart';

// Controller class for handling login logic
class LoginController {
  // Controllers for managing text input from the user
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Instance of ApiService to handle API calls
  final ApiService apiService = ApiService();

  // Method to handle the login process
  Future<void> login(BuildContext context) async {
    try {
      // Attempt to log in the user using the provided credentials
      String token = await apiService.signIn(
        emailController.text,
        passwordController.text,
      );

      // Print the received token to the console
      print('Token: $token');

      // Navigate to the main screen upon successful login
      Navigator.pushNamed(context, '/MainScreen');
    } catch (e) {
      // Print the error and show a failure message if login fails
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to log in')),
      );
    }
  }
}
