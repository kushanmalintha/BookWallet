import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class LikesApiService {
  static final String baseUrl = 'http://${ip}:3000/api/reviews';

  Future<List<Map<String, dynamic>>> fetchLikes(int reviewId) async {
    final response = await http.get(Uri.parse('$baseUrl/$reviewId/likes'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => {
                'user_id': json['user_id'],
                'username': json['username'],
              })
          .toList();
    } else {
      throw Exception('Failed to load likes');
    }
  }
}
