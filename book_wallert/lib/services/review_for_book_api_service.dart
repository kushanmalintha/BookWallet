import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
// import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';

class ReviewForBookService {
  String apiUrl(int bookId) =>
      '${ip}/api/reviews/getReviewWithBookId/$bookId';

  Future<List<ReviewModel>> fetchPosts(int bookId, int page) async {
    final response = await http.get(Uri.parse('${apiUrl(bookId)}?page=$page'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((item) => ReviewModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

// class BookIdService {
//   final String apiUrl = '${ip}/api/book/getBookId';

//   Future<int> fetchId(BookModel book) async {
//     int? bookId;

//     if (book.ISBN13.isNotEmpty) {
//       bookId = await fetchIdUsingISBN(book.ISBN13);
//     }

//     if (bookId == null && book.ISBN10.isNotEmpty) {
//       bookId = await fetchIdUsingISBN(book.ISBN10);
//     }

//     if (bookId != null) {
//       return bookId;
//     } else {
//       throw Exception('Failed to get the book id using both ISBN13 and ISBN10');
//     }
//   }

//   Future<int?> fetchIdUsingISBN(String ISBN) async {
//     final response = await http.get(Uri.parse('$apiUrl/$ISBN'));
//     print(response);

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       if (data.isNotEmpty) {
//         int bookId = data[0]['bookId'];
//         print(bookId);
//         return bookId;
//       } else {
//         throw Exception('No book ID found in the response');
//       }
//     } else {
//       throw Exception('Failed to get the book id');
//     }
//   }
// }
