import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/user.dart';

class UserIdApiService {
  Future<User?> fetchUserById(int userId) async {
    final response =
        await http.get(Uri.parse('http://$ip:3000/api/auth/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors or return null if user not found
      return null;
    }
  }
}
