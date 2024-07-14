import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/user.dart';

class ApiService {
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

  Future<String> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to sign in');
    }
  }
}
