// import 'dart:convert';
// import 'package:book_wallert/ipaddress.dart';
// import 'package:book_wallert/models/book_model.dart';
// import 'package:http/http.dart' as http;

// class WishlistApiService {
//   static final String baseUrl = 'http://${ip}:3000/api/wishlist';

//   Future<List<BookModel>> fetchWishlist(int userId) async {
//     final response = await http.get(Uri.parse('$baseUrl/$userId'));

//     if (response.statusCode == 200) {
//       print('Response: ${response.body}');
//       List<dynamic> data = json.decode(response.body);
//       print('Parsed Data: $data');
//       return data.map((json) => BookModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load wishlist');
//     }
//   }
// }
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

class WishlistApiService {
  static final String baseUrl = 'http://${ip}:3000/api/wishlist';
  static final String WishlistBaseUrl =
      'http://${ip}:3000/api/wishlist/wishlistBooks';

  Future<List<BookModel>> fetchWishlist(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      List<dynamic> data = json.decode(response.body);
      print('Parsed Data: $data');
      return data.map((json) {
        return BookModel(
          title: json['title'],
          ISBN10: json['ISBN10'].toString(),
          ISBN13: json['ISBN13'].toString(), // Convert to String if needed
          publishedDate:
              json['publication_date'], // Mapping database field to model
          description: json['description'],
          pages: json['pages'],
          author: json['author'],
          totalRating: json['rating'], // Convert to String if needed
          genre: json['genre'],
          imageUrl: json['imageUrl'],
          resource: json['resource'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load wishlist');
    }
  }
 Future<void> postwhislistDetails(int userId, int bookId, String? token) async {
    final url = Uri.parse('$WishlistBaseUrl/$bookId/$userId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Book added to wishlist successfully.');
      } else {
        print('Failed to add to wishlist. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while adding to wishlist: $e');
    }
  }
  Future<void> removeBookFromWishlist(int userId, int bookId) async {
    final url = Uri.parse('$baseUrl/remove/$userId/$bookId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Book removed from wishlist successfully.');
      } else {
        print(
            'Failed to remove from wishlist. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while removing from wishlist: $e');
    }
  }

}
