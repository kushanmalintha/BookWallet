import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class ReviewCard extends StatelessWidget {
  final Review review = Review(
    title: 'Dune Messiah',
    author: 'Frank Herbert',
    rating: 8.9,
    reviewText:
        'Dune Messiah continues the story of Paul Atreides, now Emperor of the Known Universe and known as Muad\'Dib. As he grapples with immense power, political enemies, and a conspiracy within his own.',
  );

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
                        review.title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.textColor),
                      ),
                      Text(review.author,
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
            Text(review.reviewText,
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

class Review {
  final String title;
  final String author;
  final double rating;
  final String reviewText;

  Review({
    required this.title,
    required this.author,
    required this.rating,
    required this.reviewText,
  });
}
