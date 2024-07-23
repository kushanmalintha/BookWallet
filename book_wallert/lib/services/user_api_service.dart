import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static final String _baseUrl = 'http://${ip}:3000/api/user';

  Future<User> editUserDetails(
      String username, String email, String password) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/edituserdetails'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Failed to update');
    }
  }
}
