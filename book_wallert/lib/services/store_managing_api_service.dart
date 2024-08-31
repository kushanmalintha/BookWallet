// location_service.dart
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/shop_model.dart';

class ShopService {
  final String _baseUrl = 'http://$ip:3000/api';

  Future<List<Shop>> fetchShopsForBook(int bookId) async {
    final response = await http.get(Uri.parse('$_baseUrl/stores/book/$bookId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Shop.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shops');
    }
  }
}
