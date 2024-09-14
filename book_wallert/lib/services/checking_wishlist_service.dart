import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Assuming ip is stored here

class CheckingWishlistService {
  final String baseUrl = '${ip}/api/wishlist/IsinWishlist';

  Future<bool> isBookInWishlist(int userId, int bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId/$bookId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['exists'] as bool;
    } else {
      throw Exception('Failed to check wishlist status');
    }
  }
}
