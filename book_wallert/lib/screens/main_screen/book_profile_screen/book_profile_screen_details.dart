import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BookProfileScreenDetails extends StatelessWidget {
  const BookProfileScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.bgColor,
      child: Container(
        width: double.infinity, // Take full width of the screen
        padding: const EdgeInsets.all(16.0), // Adjust padding within the card
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  height: 230,
                  decoration: const BoxDecoration(
                    color: MyColors.bgColor,
                    image: DecorationImage(
                      image: AssetImage('images/Book_Image1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dune Messiah',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MyColors.textColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Author: Frank Herbert',
                        style: TextStyle(
                          fontSize: 18,
                          color: MyColors.textColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Genre: Science Fiction',
                        style: TextStyle(
                          fontSize: 18,
                          color: MyColors.textColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rating: 8.9/10',
                        style: TextStyle(
                          fontSize: 18,
                          color: MyColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'About: Dune Messiah is a continuation of the book series dune messiah...',
              style: TextStyle(
                fontSize: 16,
                color: MyColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
