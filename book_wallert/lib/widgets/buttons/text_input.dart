import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final double rating;
  final VoidCallback onSendPressed;
  final VoidCallback onIncreaseRating;
  final VoidCallback onDecreaseRating;
  final String? hintText;

  TextInputWidget(
      {super.key,
      required this.controller,
      required this.rating,
      required this.onSendPressed,
      required this.onIncreaseRating,
      required this.onDecreaseRating,
      this.hintText,
      String? text}) {
    if (text != null) {
      controller.text = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Prevent the outer GestureDetector from closing the input
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: MyColors.panelColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: MyColors.bgColor,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                    height: 40), // Adding space for the widgets at the top
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: MyColors.textColor),
                        controller: controller,
                        minLines: 1,
                        maxLines: 10, // Set a maximum number of lines
                        onChanged: (text) {
                          // Adjust the height based on the content
                        },
                        decoration: InputDecoration(
                          hintStyle:
                              const TextStyle(color: MyColors.text2Color),
                          hintText:
                              hintText?.isNotEmpty == true ? hintText : null,
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                      ),
                    ),
                    IconButton(
                      color: MyColors.selectedItemColor,
                      icon: const Icon(Icons.send),
                      onPressed: onSendPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 8,
            child: RatingBar(rating: rating),
          ),
          Positioned(
            right: 50, // Adjust left position to avoid overlap
            child: IconButton(
                onPressed: onIncreaseRating,
                icon: const Icon(Icons.add),
                color: MyColors.nonSelectedItemColor),
          ),
          Positioned(
            right: 5, // Adjust left position to avoid overlap
            child: IconButton(
                onPressed: onDecreaseRating,
                icon: const Icon(Icons.remove),
                color: MyColors.nonSelectedItemColor),
          ),
        ],
      ),
    );
  }
}
