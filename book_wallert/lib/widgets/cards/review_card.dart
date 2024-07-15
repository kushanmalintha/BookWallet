import 'package:flutter/material.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/colors.dart';

// Review widget that displays details of a book review
class ReviewCard extends StatelessWidget {
  final ReviewModel review; // Review object

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    const double cardHeight = 190; // Hardcoded card height
    const Color backgroundColor =
        MyColors.panelColor; // Hardcoded background color

    return Center(
      child: Card(
        color: backgroundColor,
        child: SizedBox(
          height: cardHeight,
          width: screenWidth,
          child: Stack(
            children: <Widget>[
              // Book image positioned at the top left
              Positioned(
                top: 5,
                left: 5,
                child: GestureDetector(
                  onTap: () {
                    // go to the book profile
                    print("hello");
                  },
                  child: SizedBox(
                    height: 120,
                    width: 90,
                    child: Image.asset(review.imagePath, fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                      return Container(
                        color: MyColors.text2Color,
                      );
                    }),
                  ),
                ),
              ),
              // Book name positioned next to the image
              Positioned(
                top: 2,
                left: 105,
                child: GestureDetector(
                  onTap: () {
                    // go to the book profile
                    print("hello");
                  },
                  child: Text(
                    review.bookName,
                    style: const TextStyle(
                      color: MyColors.textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // Author name positioned next to the book name
              Positioned(
                top: 12,
                left: 225,
                child: Text(
                  review.authorName,
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
              // Book context positioned below the divider
              Positioned(
                top: 30,
                left: 105,
                right: 20,
                child: Text(
                  review.context,
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
                  ('${review.rating}/10'),
                  style: const TextStyle(
                    color: MyColors.text2Color,
                    fontSize: 12,
                  ),
                ),
              ),
              // Reviewed by positioned next to the rating
              const Positioned(
                bottom: 42,
                left: 200,
                child: Text(
                  'ReviewedBy',
                  style: TextStyle(
                    color: MyColors.text2Color,
                    fontSize: 8,
                  ),
                ),
              ),
              // reviwername positioned next to the reviewed by text
              Positioned(
                bottom: 40,
                left: 250,
                child: GestureDetector(
                  onTap: () {
                    // go to the reviwer profile
                    print("hello");
                  },
                  child: Text(
                    review.reviwerName,
                    style: const TextStyle(
                      color: MyColors.text2Color,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Icon button positioned at the bottom right
              Positioned(
                bottom: 40,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    // go to the reviwer profile
                    print("hello");
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/Book_Image1.jpg',
                    ),
                    radius: 10,
                  ),
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
      ),
    );
  }
}
