import 'package:book_wallert/controllers/review_delete_controller.dart';
import 'package:book_wallert/controllers/saved_controller.dart';
import 'package:book_wallert/controllers/wishlist_controller.dart';
import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/functions/global_navigator_animation.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:book_wallert/screens/main_screen/review_screens/review_screen_body.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:book_wallert/widgets/buttons/comment_button.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:book_wallert/widgets/buttons/like_button.dart';
import 'package:book_wallert/widgets/buttons/share_button.dart';
import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/review_comments_controller.dart';

class ReviewCard extends StatefulWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isComment = false;
  bool _isOverflow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _handleCommentChanged(bool value) {
    setState(() {
      _isComment = value;
    });
  }

  void _checkOverflow() {
    final textSpan = TextSpan(
      text: widget.review.context.length > 150
          ? '${widget.review.context.substring(0, 150)}...'
          : widget.review.context,
      style: const TextStyle(
        color: MyColors.textColor,
        fontSize: 14,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      maxWidth: MediaQuery.of(context).size.width,
    );
    setState(() {
      _isOverflow = widget.review.context.length > 150;
    });
  }

  void _hideTextInput() {
    setState(() {
      _isComment = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ReviewDeleteController reviewDeleteController =
        ReviewDeleteController(widget.review.reviewId, widget.review.userId);
    final WishlistController wishlistController =
        WishlistController(WishlistApiService());
    final savedController = SavedController(globalUser!.userId);

    //print(widget.review.bookId);
    print(widget.review.userId);
    return GestureDetector(
      onTap: () {
        if (_isComment) {
          _hideTextInput();
        }
      },
      child: Stack(
        children: [
          Center(
            child: Card(
              elevation: 0,
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
                                context,
                                BookProfileScreenBody(
                                  bookId: widget.review.bookId,
                                  book: dummyBook,
                                ));
                          },
                          child: SizedBox(
                            width: 80,
                            child: Image.network(
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
                                  screenChange(
                                      context,
                                      BookProfileScreenBody(
                                        bookId: widget.review.bookId,
                                        book: dummyBook,
                                      ));
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
                              const Divider(
                                  color: MyColors.nonSelectedItemColor),
                              GestureDetector(
                                onTap: () {
                                  screenChangeAnimation(context,
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
                                            widget.review.context.length > 150
                                                ? '${widget.review.context.substring(0, 150)}...'
                                                : widget.review.context,
                                            style: const TextStyle(
                                              color: MyColors.textColor,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          if (_isOverflow)
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
                            screenChange(
                                context,
                                UserProfileScreenBody(
                                    userId: widget.review.userId)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.review.date,
                          style: const TextStyle(
                              color: MyColors.text2Color,
                              fontSize:
                                  11), // Apply the style to the Text widget
                        ),
                      ],
                    ),
                    const Divider(color: MyColors.nonSelectedItemColor),
                    SizedBox(
                      height: 34,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LikeButton(
                              review: widget.review,
                              icon: Icons.thumb_up,
                              likesCount: widget.review.likesCount),
                          CommentButton(
                            review: widget.review,
                            icon: Icons.comment,
                            isComment: _isComment,
                            commentsCount: widget.review.commentsCount,
                            onCommentChanged: _handleCommentChanged,
                          ),
                          //add the share button
                          ShareButton(
                              review: widget.review,
                              icon: Icons.share,
                              sharesCount: widget.review.sharesCount),
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
                items: widget.review.userId == globalUser!.userId
                    ? const [
                        'Add this book to Wishlist',
                        'Save Review',
                        'Delete review'
                      ]
                    : ['Add this book to Wishlist', 'Save review'],
                onItemTap: widget.review.userId == globalUser!.userId
                    ? [
                        () {
                          wishlistController.addBookToWishlist(
                              globalUser!.userId, widget.review.bookId);
                        },
                        () {
                          savedController
                              .insertReviewToSaved(widget.review.reviewId);
                        },
                        () {
                          // delete function
                          reviewDeleteController.deleteReview(context);
                        }
                      ]
                    : [
                        () {},
                        () {
                          savedController
                              .insertReviewToSaved(widget.review.reviewId);
                        },
                      ],
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: MyColors.nonSelectedItemColor,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput() {
    // Create an instance of CommentController
    final commentController = CommentController(widget.review.reviewId);

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
                        controller: commentController
                            .commentController, // Use the controller from CommentController
                        style: const TextStyle(color: MyColors.textColor),
                        minLines: 1,
                        maxLines: 10, // Set a maximum number of lines
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: MyColors.text2Color),
                          hintText: 'Write your comment...',
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                      ),
                    ),
                    IconButton(
                      color: MyColors.selectedItemColor,
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        // Call the addComment method from CommentController
                        final commentText =
                            commentController.commentController.text;

                        if (commentText.isNotEmpty) {
                          try {
                            await commentController.addComment(context);
                            setState(() {
                              _isComment = false;
                            });
                          } catch (e) {
                            print('Error adding comment: $e');
                          }
                        } else {
                          print('Comment cannot be empty');
                        }
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
