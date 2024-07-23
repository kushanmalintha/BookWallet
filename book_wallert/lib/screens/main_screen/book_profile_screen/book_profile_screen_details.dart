import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart'; // Import your BookModel class

class BookProfileScreenDetails extends StatelessWidget {
  final BookModel book;

  const BookProfileScreenDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: MyColors.bgColor,
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 250,
            // width: 400,
            child: Image.network(
              book.imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            book.title, // Use the title from the BookModel object
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyColors.textColor,
            ),
          ),
          Text(
            'Author: ${book.author}', // Use the author from the BookModel object
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
          ),
          Text(
            'Genre: ${book.genre}', // Use the genre from the BookModel object
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
          ),
          Text(
            'Rating: ${book.totalRating}/10', // Use the totalRating from the BookModel object
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
          ),
          Text(
            'Pages: ${book.pages}', // Use the totalRating from the BookModel object
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
          ),
          Text(
            book.description,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Resource',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}









// Card(
//       color: MyColors.bgColor,
//       child: Container(
//         width: double.infinity, // Take full width of the screen
//         padding: const EdgeInsets.all(16.0), // Adjust padding within the card
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 60,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: MyColors.bgColor,
//                     image: DecorationImage(
//                       image: AssetImage(book
//                           .imageUrl), // Use the imageUrl from the BookModel object
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         book.title, // Use the title from the BookModel object
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: MyColors.textColor,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Author: ${book.author}', // Use the author from the BookModel object
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: MyColors.textColor,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Genre: ${book.genre}', // Use the genre from the BookModel object
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: MyColors.textColor,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Rating: ${book.totalRating}/10', // Use the totalRating from the BookModel object
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: MyColors.textColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'About: Dune Messiah is a continuation of the book series Dune Messiah...', // You can add an 'about' property to the BookModel if needed
//               style: TextStyle(
//                 fontSize: 16,
//                 color: MyColors.textColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );