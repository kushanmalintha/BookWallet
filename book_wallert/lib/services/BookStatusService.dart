import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Assuming the IP is stored here

class BookStatusService {
  final String baseUrl = '${ip}/api/books';

  Future<Map<String, bool>> checkBookStatus(int userId, int bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId/$bookId/status'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'wishlistStatus': data['wishlistStatus'] as bool,
        'saveStatus': data['saveStatus'] as bool,
      };
    } else {
      throw Exception('Failed to check book status');
    }
  }
}
