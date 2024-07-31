import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:book_wallert/screens/review_screens/review_screen_body.dart';
import 'package:book_wallert/widgets/buttons/comment_button.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:book_wallert/widgets/buttons/like_button.dart';
import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/colors.dart';

class ReviewCard extends StatefulWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isComment = false;

  void _handleCommentChanged(bool value) {
    setState(() {
      _isComment = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Card(
            color: MyColors.panelColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          screenChange(
                              context, BookProfileScreenBody(book: dummyBook));
                        },
                        child: SizedBox(
                          width: 80,
                          child: Image.asset(
                            widget.review.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Container(
                                color: MyColors.text2Color,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                screenChange(context,
                                    BookProfileScreenBody(book: dummyBook));
                              },
                              child: Text(
                                widget.review.bookName,
                                style: const TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              'Author: ${widget.review.authorName}',
                              style: const TextStyle(
                                color: MyColors.text2Color,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const Divider(color: MyColors.nonSelectedItemColor),
                            GestureDetector(
                              onTap: () {
                                screenChange(context,
                                    ReviewScreenBody(review: widget.review));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.review.context,
                                          style: const TextStyle(
                                            color: MyColors.textColor,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Text(
                                          'see more',
                                          style: TextStyle(
                                              color: MyColors.text2Color),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text(
                            'Rating: ',
                            style: TextStyle(
                              color: MyColors.text2Color,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          RatingBar(rating: widget.review.rating),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => {
                          screenChange(context,
                              UserProfileScreenBody(userId: dummyUser.userId)),
                        },
                        child: Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Reviewed by: ',
                                    style: TextStyle(
                                      color: MyColors.text2Color,
                                      fontSize: 8,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.review.reviwerName,
                                    style: const TextStyle(
                                      color: MyColors.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/Book_Image1.jpg'),
                              radius: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: MyColors.nonSelectedItemColor),
                  SizedBox(
                    height: 34,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LikeButton(review: widget.review, icon: Icons.thumb_up),
                        CommentButton(
                          review: widget.review,
                          icon: Icons.comment,
                          isComment: _isComment,
                          onCommentChanged: _handleCommentChanged,
                        ),
                        LikeButton(review: widget.review, icon: Icons.share),
                      ],
                    ),
                  ),
                  if (_isComment) _buildTextInput(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CustomPopupMenuButtons(
              items: const [
                'Add this book to Wishlist',
                'Save review',
              ],
              onItemTap: [
                // Item actions
                () {},
                () {},
              ],
              icon: const Icon(
                Icons.more_vert_rounded,
                color: MyColors.nonSelectedItemColor,
              )),
        ),
      ],
    );
  }

  Widget _buildTextInput() {
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: MyColors.textColor),
                        minLines: 1,
                        maxLines: 10, // Set a maximum number of lines
                        onChanged: (text) {
                          setState(() {
                            // Adjust the height based on the content
                          });
                        },
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: MyColors.text2Color),
                          hintText: 'Write your review...',
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                      ),
                    ),
                    IconButton(
                      color: MyColors.selectedItemColor,
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Handle send action
                        setState(() {
                          _isComment = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
