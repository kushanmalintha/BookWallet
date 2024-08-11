import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;

class GetUserProfileService {
  final String apiUrl = 'http://$ip:3000/api/user/getuserprofile';

  Future<User> fetchUserProfile(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((item) => User.fromJson(item)).toList()[0];
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
