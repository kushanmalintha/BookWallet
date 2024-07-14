import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';

class HomeListScreenBody extends StatelessWidget {
  const HomeListScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
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
