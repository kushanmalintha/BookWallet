import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
}
