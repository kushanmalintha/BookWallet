import 'package:book_wallert/colors.dart';
import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review = dummyReview;

  ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/Book_Image1.jpg',
                  width: 50,
                  height: 75,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.bookName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.textColor),
                      ),
                      Text(review.authorName,
                          style: const TextStyle(color: MyColors.textColor)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text('${review.rating}/10',
                              style:
                                  const TextStyle(color: MyColors.textColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(review.context,
                style: const TextStyle(color: MyColors.textColor)),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text('2344', style: TextStyle(color: MyColors.textColor)),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text('465', style: TextStyle(color: MyColors.textColor)),
                SizedBox(width: 16),
                Icon(Icons.share_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text('49', style: TextStyle(color: MyColors.textColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
