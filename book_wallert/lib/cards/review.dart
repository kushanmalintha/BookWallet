import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String imagePath;
  final String bookName;
  final String authorName;
  final String description;
  final String rating;
  final String reviewedBy;
  final String userName;

  const Review({
    super.key,
    required this.height,
    required this.width,
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
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 8,
            child: Image.asset(
              imagePath,
              width: width * 0.22,
            ),
          ),
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
          Positioned(
            top: 25,
            left: 105,
            child: Container(
              width: 175,
              height: 1,
              color: MyColors.textColor,
            ),
          ),
          Positioned(
            top: 30,
            left: 105,
            right: 20,
            child: Text(
              description,
              style: const TextStyle(
                color: MyColors.text2Color,
                fontSize: 10,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
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
          Positioned(
            bottom: 36,
            child: Container(
              width: 400,
              height: 1,
              color: MyColors.textColor,
            ),
          ),
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
                      // share  function
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
