import 'dart:convert';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;

class GetUserProfileService {
  static String apiUrl = '${ip}/api/user/getuserprofile';

  Future<User> fetchUserProfile(int userId) async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            '$token', // Include the token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => User.fromJson(item)).toList()[0];
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
