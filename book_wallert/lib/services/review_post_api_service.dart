import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class ReviewPostApiService {
  static final String _baseUrl = 'http://${ip}:3000/api/reviews';
  Future<String?> reviewPost(String review) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reviewpost'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'review': review}),
    );

    if (response.statusCode == 200) {
      //return jsonDecode(response.body);
      return null;
    } else {
      throw Exception('Failed to post review');
    }
  }
}
