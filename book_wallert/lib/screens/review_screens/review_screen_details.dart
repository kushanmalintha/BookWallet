import 'package:book_wallert/colors.dart';
import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewScreenDetails extends StatefulWidget {
  final ReviewModel review;

  const ReviewScreenDetails({super.key, required this.review});

  @override
  State<ReviewScreenDetails> createState() {
    return _ReviewScreenDetailsState();
  }
}

class _ReviewScreenDetailsState extends State<ReviewScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Card(
            color: MyColors.bgColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      screenChange(
                          context, BookProfileScreenBody(book: dummyBook));
                    },
                    child: SizedBox(
                      width: 80,
                      child: Image.network(widget.review.imagePath,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      screenChange(
                          context, BookProfileScreenBody(book: dummyBook));
                    },
                    child: Text(
                      widget.review.bookName,
                      style: const TextStyle(
                          color: MyColors.textColor, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Author: ${widget.review.authorName}',
                    style: const TextStyle(
                        color: MyColors.textColor, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.review.context,
                    style: const TextStyle(
                        color: MyColors.textColor, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Reviewed by: ${widget.review.reviwerName}',
                    style: const TextStyle(
                        color: MyColors.textColor, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  RatingBar(rating: widget.review.rating)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CustomPopupMenuButtons(
            items: const ['menu'],
            onItemTap: [() {}],
            icon: const Icon(Icons.more_vert_rounded,
                color: MyColors.nonSelectedItemColor),
          ),
        ),
      ],
    );
  }
}
