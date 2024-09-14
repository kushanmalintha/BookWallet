import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

class TrendingService {
  static final String baseUrl = '${ip}/api/trending/trendingBooks';

  Future<List<BookModel>> fetchTrendingBooks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      List<dynamic> data = json.decode(response.body);
      return data.map((json) {
        return BookModel(
          title: json['title'],
          ISBN10: json['ISBN10'].toString(),
          ISBN13: json['ISBN13'].toString(), 
          publishedDate: json['publication_date'],
          description: json['description'],
          pages: json['pages'],
          author: json['author'],
          totalRating: json['rating'],
          genre: json['genre'],
          imageUrl: json['imageUrl'],
          resource: json['resource'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load trending books');
    }
  }
}
