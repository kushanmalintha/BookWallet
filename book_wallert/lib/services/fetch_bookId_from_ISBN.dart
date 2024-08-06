import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

class BookIdService {
  final String apiUrl = 'http://${ip}:3000/api/book/getBookId';

  Future<int> fetchId(BookModel book) async {
    int? bookId;
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'book': {
          'title': book.title,
          'ISBN10': book.ISBN10,
          'ISBN13': book.ISBN13,
          'publication_date': book.publishedDate,
          'description': book.description,
          'author': book.author,
          'rating': book.totalRating, // Assuming this is the book rating
          'pages': book.pages,
          'genre': book.genre,
          'imageUrl': book.imageUrl,
          'resource': book.resource
        },
      }),
    );
    print(response.body);
    bookId = jsonDecode(response.body)["bookId"];
    return bookId!;

    // if (book.ISBN13.isNotEmpty) {
    //   bookId = await fetchIdUsingISBN(book.ISBN13);
    // }

    // if (bookId == null && book.ISBN10.isNotEmpty) {
    //   bookId = await fetchIdUsingISBN(book.ISBN10);
    // }

    // if (bookId != null) {
    //   return bookId;
    // } else {
    //   throw Exception('Failed to get the book id using both ISBN13 and ISBN10');
    // }
  }

  Future<int?> fetchIdUsingISBN(String ISBN) async {
    final response = await http.get(Uri.parse('$apiUrl/$ISBN'));
    print(response);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        int bookId = data[0]['bookId'];
        print(bookId);
        return bookId;
      } else {
        throw Exception('No book ID found in the response');
      }
    } else {
      throw Exception('Failed to get the book id');
    }
  }
}
