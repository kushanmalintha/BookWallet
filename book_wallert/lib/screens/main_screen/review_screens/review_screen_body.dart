import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/history_controller.dart';
import 'package:book_wallert/controllers/review_controller.dart';
import 'package:book_wallert/controllers/review_update_controller.dart';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/screens/main_screen/review_screens/review_screen_details.dart';
import 'package:book_wallert/screens/main_screen/review_screens/review_screen_list.dart';
import 'package:book_wallert/widgets/buttons/floating_action_button.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';
import 'package:book_wallert/widgets/buttons/text_input.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class ReviewScreenBody extends StatefulWidget {
  ReviewModel? review; // The review data object
  int reviewId; // The ID of the review
  final int index; // The index of the selected tab

  ReviewScreenBody(
      {super.key, this.review, this.reviewId = -1, this.index = 0});

  @override
  State<ReviewScreenBody> createState() => _ReviewScreenBodyState();
}

class _ReviewScreenBodyState extends State<ReviewScreenBody>
    with SingleTickerProviderStateMixin {
  late final ReviewUpdateController _reviewUpdateController;
  late final HistoryController _historyController;
  final ReviewController _reviewController = ReviewController();
  late TabController _tabController; // Controller for managing tabs
  late ScrollController _scrollController; // Controller for handling scrolling

  final List<String> _tabNames = [
    'Comment',
    'Like',
    'Share'
  ]; // Names of the tabs

  final double scrollThreshold =
      300; // Scroll threshold for specific functionality
  bool _isWriting = false; // Tracks if the user is writing a review
  late double _rating; // Rating value for the review
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with the number of tabs
    _tabController = TabController(length: _tabNames.length, vsync: this);

    // Initialize ScrollController and set up listener for scroll events
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Fetch review data if reviewId is provided
    if (widget.reviewId != -1) {
      _getReviewWithId();
    } else {
      // Set the initial rating from the review object
      _rating = widget.review!.rating;

      // Initialize the ReviewUpdateController and HistoryController
      _reviewUpdateController = ReviewUpdateController(
          widget.review!.reviewId, widget.review!.userId);
      _historyController = HistoryController(globalUser!.userId);

      // Insert review history for tracking purposes
      _insertHistory();
    }
  }

  // Fetch the review details based on the provided reviewId
  Future<void> _getReviewWithId() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final fetchReview = await _reviewController.fetchReview(widget.reviewId);
      setState(() {
        widget.review = fetchReview;
        _isLoading = false;
        // Set the initial rating from the review object
        _rating = widget.review!.rating;

        // Initialize the ReviewUpdateController and HistoryController
        _reviewUpdateController = ReviewUpdateController(
            widget.review!.reviewId, widget.review!.userId);
        _historyController = HistoryController(globalUser!.userId);

        // Insert review history for tracking purposes
        _insertHistory();
      });
    } catch (e) {
      print('Error fetching review: $e');
    }
  }

  // Insert review history to track user interaction
  Future<void> _insertHistory() async {
    final String? token = await getToken();
    await _historyController.insertReviewHistory(
        token, widget.review!.reviewId);
  }

  // Increase the rating value, maxing out at 5.0
  void _increaseRating() {
    setState(() {
      if (_rating < 5.0) {
        _rating += 0.5; // Increment rating by 0.5
      }
    });
  }

  // Decrease the rating value, bottoming out at 0.0
  void _decreaseRating() {
    setState(() {
      if (_rating > 0.0) {
        _rating -= 0.5; // Decrement rating by 0.5
      }
    });
  }

  // Listener to manage scroll events
  void _scrollListener() {
    if (_scrollController.offset >= scrollThreshold &&
        !_scrollController.position.outOfRange) {
      _scrollController
          .jumpTo(scrollThreshold); // Prevent scrolling beyond threshold
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set the initial index for the tabs
    _tabController.index = widget.index;

    return Scaffold(
      backgroundColor: MyColors.bgColor, // Set background color
      body: _isLoading
          ? Center(child: buildProgressIndicator())
          : GestureDetector(
              onTap: () {
                if (_isWriting) {
                  setState(() {
                    _isWriting = false;
                  });
                }
              },
              child: Stack(
                children: [
                  // Main content centered on the screen
                  Center(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        // Display review details
                        SliverToBoxAdapter(
                          child: ReviewScreenDetails(review: widget.review!),
                        ),
                        // Tab bar for selection between different review actions
                        SliverToBoxAdapter(
                          child: SelectionBar(
                            tabController: _tabController,
                            tabNames: _tabNames,
                          ),
                        ),
                        // Content of the selected tab
                        SliverFillRemaining(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ReviewScreenListView(
                                  reviewId: widget.review!.reviewId,
                                  screenName: 'Comment'),
                              ReviewScreenListView(
                                  reviewId: widget.review!.reviewId,
                                  screenName: 'Like'),
                              ReviewScreenListView(
                                  reviewId: widget.review!.reviewId,
                                  screenName: 'Share'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Display floating action button or text input if the review belongs to the current user
                  if (widget.review!.userId == globalUser!.userId)
                    Positioned(
                      right: 16.0,
                      bottom: 16.0,
                      child: _isWriting
                          ? TextInputWidget(
                              controller: _reviewUpdateController
                                  .reviewUpdateController,
                              rating: _rating,
                              text: widget.review!.context,
                              onSendPressed: () async {
                                setState(() {
                                  _isWriting = false;
                                });
                                _reviewUpdateController.rating = _rating;
                                await _reviewUpdateController
                                    .updateReview(context);
                              },
                              onIncreaseRating: _increaseRating,
                              onDecreaseRating: _decreaseRating,
                            )
                          : FloatingActionButtonWidget(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  _isWriting = true;
                                });
                              },
                            ),
                    ),
                ],
              ),
            ),
    );
  }
}
