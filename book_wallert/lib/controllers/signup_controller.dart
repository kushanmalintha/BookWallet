import 'package:flutter/material.dart';
import 'package:book_wallert/services/api_services.dart';
import 'package:book_wallert/screens/login_screens/login_screen.dart';

// Controller class for handling signup logic
class SignupController {
  // Controllers for managing text input from the user
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Instance of ApiService to handle API calls
  final ApiService apiService = ApiService();

  // Method to handle the signup process
  Future<void> signUp(BuildContext context) async {
    // Check if the passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // Show a message if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Attempt to sign up the user using the provided credentials
      await apiService.signUp(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
      // Navigate to the login screen upon successful signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Print the error and show a failure message if signup fails
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign up')),
      );
    }
  }
}
