import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// Review widget that displays details of a book review
class Review extends StatelessWidget {
  final double cardHeight; // Height of the review card
  final Color backgroundColor; // Background color of the review card
  final String imagePath; // Path to the image of the book
  final String bookName; // Name of the book
  final String authorName; // Name of the author
  final String description; // Description of the book
  final String rating; // Rating of the book
  final String reviewedBy; // Name of the reviewer
  final String userName; // Username of the reviewer

  const Review({
    super.key,
    required this.cardHeight,
    required this.backgroundColor,
    required this.imagePath,
    required this.bookName,
    required this.authorName,
    required this.description,
    required this.rating,
    required this.reviewedBy,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    return Card(
      color: backgroundColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(), // Rounded corners for the card
      // ),
      child: SizedBox(
        height: cardHeight,
        width: screenWidth,
        child: Stack(
          children: <Widget>[
            // Book image positioned at the top left
            Positioned(
              top: 5,
              left: 5,
              child: SizedBox(
                height: 120,
                width: 90,
                child: Image.asset(imagePath, fit: BoxFit.cover, errorBuilder:
                    (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                  return Container(
                    color: MyColors.text2Color,
                  );
                }),
              ),
            ),
            // Book name positioned next to the image
            Positioned(
              top: 2,
              left: 105,
              child: Text(
                bookName,
                style: const TextStyle(
                  color: MyColors.textColor,
                  fontSize: 18,
                ),
              ),
            ),
            // Author name positioned next to the book name
            Positioned(
              top: 12,
              left: 225,
              child: Text(
                authorName,
                style: const TextStyle(
                  color: MyColors.textColor,
                  fontSize: 8,
                ),
              ),
            ),
            // Divider line under the book name
            Positioned(
              top: 25,
              left: 105,
              child: Container(
                width: 175,
                height: 1,
                color: MyColors.textColor,
              ),
            ),
            // Book description positioned below the divider
            Positioned(
              top: 30,
              left: 105,
              right: 20,
              child: Text(
                description,
                style: const TextStyle(
                  color: MyColors.text2Color,
                  fontSize: 11,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            // Rating positioned at the bottom left
            Positioned(
              bottom: 40,
              left: 20,
              child: Text(
                rating,
                style: const TextStyle(
                  color: MyColors.text2Color,
                  fontSize: 12,
                ),
              ),
            ),
            // Reviewed by positioned next to the rating
            Positioned(
              bottom: 42,
              left: 200,
              child: Text(
                reviewedBy,
                style: const TextStyle(
                  color: MyColors.text2Color,
                  fontSize: 8,
                ),
              ),
            ),
            // Username positioned next to the reviewed by text
            Positioned(
              bottom: 40,
              left: 250,
              child: Text(
                userName,
                style: const TextStyle(
                  color: MyColors.text2Color,
                  fontSize: 12,
                ),
              ),
            ),
            // Icon button positioned at the bottom right
            Positioned(
              bottom: 25,
              right: -8,
              child: IconButton(
                icon: const Icon(Icons.person),
                color: MyColors.nonSelectedItemColor,
                iconSize: 20,
                onPressed: () {
                  // like function
                },
              ),
            ),
            // Divider line positioned above the action buttons
            Positioned(
              bottom: 36,
              child: Container(
                width: screenWidth,
                height: 1,
                color: MyColors.textColor,
              ),
            ),
            // Row of action buttons (like, comment, share) at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      color: MyColors.nonSelectedItemColor,
                      iconSize: 20,
                      onPressed: () {
                        // like function
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      color: MyColors.nonSelectedItemColor,
                      iconSize: 20,
                      onPressed: () {
                        // comment function
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      color: MyColors.nonSelectedItemColor,
                      iconSize: 20,
                      onPressed: () {
                        // share function
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
