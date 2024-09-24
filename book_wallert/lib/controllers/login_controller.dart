//import 'dart:convert';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/user.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/auth_api_services.dart';

// Controller class for handling login logic
class LoginController {
  // Controllers for managing text input from the user
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Instance of ApiService to handle API calls
  final AuthApiService apiService = AuthApiService();

  // Method to handle the login process
  Future<void> login(BuildContext context) async {
    try {
      // Attempt to log in the user using the provided credentials
      Map<String, dynamic> response = await apiService.signIn(
        emailController.text,
        passwordController.text,
      );

      // Extract token and user details from the response
      String token = response['token'];
      User user = User(
          userId: response['userId'],
          username: response['username'],
          email: response['email'],
          imageUrl: response['imageUrl'],
          description: response['description']);

      print(user);
      // Print the received token to the console
      print('Token: $token');
      // Store the token
      storeToken(token);
      setUser(user);
      // Navigate to the main screen upon successful login
      if (context.mounted) {
        Navigator.pushNamed(context, '/MainScreen');
      }
    } catch (e) {
      // Print the error and show a failure message if login fails
      print(e);
      print('login error: $e');
      if (e is Exception) {
        print('Exception details: ${e.toString()}');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log in')),
        );
      }
    }
  }

  static Future<void> loginWithToken(BuildContext context) async {
    final Map<String, dynamic>? response =
        await AuthApiService.fetchProtectedData(context);
    if (response != null) {
      // Handle the response data
      User user = User(
          userId: response['userId'],
          username: response['username'],
          email: response['email'],
          imageUrl: response['imageUrl'],
          description: response['description']);
      print(user);
      // Update the user provider
      setUser(user);
      // print(globalUser!.id);
      // print(globalUser!.username);
      // print(globalUser!.email);
      if (context.mounted) Navigator.pushNamed(context, '/MainScreen');
    } else {
      if (context.mounted) Navigator.pushNamed(context, '/LoginScreen');
    }
  }
}
