import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';

class UserActivityService {
  final int userId;

  UserActivityService(this.userId);

  Future<List<dynamic>> fetchUserActivity() async {
    try {
      final url = Uri.parse('http://$ip:3000/api/reviews/activities/$userId');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        // Ensure the response body is not null and is valid JSON
        final jsonResponse = json.decode(response.body);
        print(
            'Raw Response: ${response.body}'); // Print the raw response for debugging

        if (jsonResponse is List<dynamic>) {
          print('Parsed Data: $jsonResponse'); // Print the parsed data

          return jsonResponse.map((item) {
            if (item['type'] == 'shared') {
              return SharedReview.fromJson(item['review']);
            } else {
              return ReviewModel.fromJson(item['review']);
            }
          }).toList();
        } else {
          throw Exception(
              'Expected a JSON list but got a different format: $jsonResponse');
        }
      } else {
        throw Exception(
            'Failed to load user activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user activity: $e');
      rethrow;
    }
  }
}
