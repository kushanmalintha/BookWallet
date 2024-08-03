import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

class WishlistApiService {
  static final String baseUrl = 'http://${ip}:3000/api/wishlist';

  Future<List<BookModel>> fetchWishlist(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      List<dynamic> data = json.decode(response.body);
      print('Parsed Data: $data');
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load wishlist');
    }
  }
}
