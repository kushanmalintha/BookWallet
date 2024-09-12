// import 'package:book_wallert/controllers/token_controller.dart';
// import 'package:book_wallert/ipaddress.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserfollowController {
//   static Future<bool> followUser(int followerId, int followedId) async {
//     final token = await getToken(); // Retrieve the token
//     final response = await http.post(
//       Uri.parse('http://${ip}:3000/api/users/follow'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'followerId': followerId,
//         'followedId': followedId,
//         'token': token,
//       }),
//     );

//     return response.statusCode == 200;
//   }

//   static Future<bool> unfollowUser(int followerId, int followedId) async {
//     final token = await getToken(); // Retrieve the token
//     final response = await http.post(
//       Uri.parse('http://${ip}:3000/api/users/unfollow'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'followerId': followerId,
//         'followedId': followedId,
//         'token': token,
//       }),
//     );

//     return response.statusCode == 200;
//   }

//   static Future<bool> checkFollowStatus(int followerId, int followedId) async {
//     final response = await http.get(
//       Uri.parse(
//           'http://${ip}:3000/api/users/check-follow?followerId=$followerId&followedId=$followedId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['isFollowing'] ?? false;
//     } else {
//       throw Exception('Failed to check follow status');
//     }
//   }
// }
// user_follow_controller.dart

import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/services/user_follow_api_service.dart';

class UserFollowController {
  static Future<bool> followUser(int followerId, int followedId) async {
    final token = await getToken(); // Retrieve the token
    print(token);
    return UserFollowService.followUser(followerId, followedId, token!);
  }

  static Future<bool> unfollowUser(int followerId, int followedId) async {
    final token = await getToken(); // Retrieve the token
    return UserFollowService.unfollowUser(followerId, followedId, token!);
  }

  static Future<bool> checkFollowStatus(int followerId, int followedId) async {
    return UserFollowService.checkFollowStatus(followerId, followedId);
  }
}
