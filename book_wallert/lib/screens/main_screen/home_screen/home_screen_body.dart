import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/cards/review_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // List of review data
    final List<Map<String, String>> reviews = [
      {
        'imagePath': 'images/Book_Image1.jpg',
        'bookName': 'Dune Messiah',
        'authorName': 'Frank Herbert',
        'description':
            "Dune Messiah continues the story of Paul Atredes, now Emperor of the Known Universe and known as Muad'Dib. As he grapples with immense power, political enemies, and a conspiracy within his own",
        'rating': 'Rating : 8.9/10',
        'reviewedBy': 'Reviewed By : ',
        'userName': 'Ravindu Pathirage',
      },
      // Add more review maps here if needed
    ];

    int reviewCount = 5;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(reviewCount, (index) {
            final review = reviews[index % reviews.length];
            return Column(
              children: [
                const SizedBox(height: 8),
                Review(
                  height: 190,
                  backgroundColor: MyColors.panelColor,
                  imagePath: review['imagePath']!,
                  bookName: review['bookName']!,
                  authorName: review['authorName']!,
                  description: review['description']!,
                  rating: review['rating']!,
                  reviewedBy: review['reviewedBy']!,
                  userName: review['userName']!,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
