import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';

class HomeListScreenBody extends StatelessWidget {
  const HomeListScreenBody({super.key});

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
            return Column(
              children: [
                const SizedBox(height: 3),
                ReviewCard(review: dummyReview,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
