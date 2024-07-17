import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/book_model.dart'; // Import your BookModel class

class BookProfileScreenDetails extends StatelessWidget {
  final BookModel book;

  const BookProfileScreenDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.bgColor,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(book.imageUrl),
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
            'About: Dune Messiah is a continuation of the book meawanm suprir stireh bn heta utaja aamaa abakaeue aeb eae ejwwhw ahc foihfsoivh ofshvosvh vhv rhohro rhfhqfpohqwhfqwphicbibdpsiupi qwcuewiuqweuhdqw;hedqwhufh wqiuhfqwfbfjrwfbqiuwciu qwuh upqwhuhqwu cpqwuecw cpquhcpuqehpwhfqwhiqwhf whfhrhh pqwhhwhfqrwhsexy wehfoqwi fhwrhfpqwfriphf qwhrwg series Dune Messiah...', // You can add an 'about' property to the BookModel if needed
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
            ),
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