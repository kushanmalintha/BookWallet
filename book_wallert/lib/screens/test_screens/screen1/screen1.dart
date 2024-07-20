import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RatingBar(
          rating: 4.5,
        ),
      ),
    );
  }
}
