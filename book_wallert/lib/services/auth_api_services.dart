import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/user.dart';

class AuthApiService {
  static final String _baseUrl =
      'http://${ip}:3000/api/auth'; // Replace with your server URL
        
  Future<User> signUp(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  static Future<String?> fetchProtectedData(BuildContext context) async {
    final token = await getToken();
    if (token == null) {
      if (context.mounted) Navigator.pushNamed(context, '/LoginScreen');
    } else {
      // print('whaaaaaat: $_baseUrl/protected');
      final response = await http.get(
        Uri.parse('$_baseUrl/protected'),
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) {
        // Handle the response data
        return response.body;
      } else {
        return null;
      }
    }
    return null;
  }
}
