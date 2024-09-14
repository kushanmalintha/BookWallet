// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HttpService {
//   static Future<http.Response> post(
//       String url, Map<String, dynamic> body) async {
//     return await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );
//   }
// }
// user_follow_service.dart

import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserFollowService {
  static Future<bool> followUser(
      int followerId, int followedId, String token) async {
    final response = await http.post(
      Uri.parse('${ip}/api/users/follow'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'followerId': followerId,
        'followedId': followedId,
        'token': token,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> unfollowUser(
      int followerId, int followedId, String token) async {
    final response = await http.post(
      Uri.parse('${ip}/api/users/unfollow'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'followerId': followerId,
        'followedId': followedId,
        'token': token,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> checkFollowStatus(int followerId, int followedId) async {
    final response = await http.get(
      Uri.parse(
          '${ip}/api/users/check-follow?followerId=$followerId&followedId=$followedId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['isFollowing'] ?? false;
    } else {
      throw Exception('Failed to check follow status');
    }
  }
}
