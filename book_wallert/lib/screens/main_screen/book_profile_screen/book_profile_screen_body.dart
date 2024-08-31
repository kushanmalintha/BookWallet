import 'package:book_wallert/controllers/get_book_api_controller.dart';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_locations_list_view.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_review_list_view.dart';
import 'package:book_wallert/services/fetch_bookId_from_ISBN.dart';
import 'package:book_wallert/services/history_api_service.dart';
import 'package:book_wallert/widgets/buttons/floating_action_button.dart';
import 'package:book_wallert/widgets/buttons/text_input.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/controllers/review_post_controller.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_details.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';
import 'package:book_wallert/colors.dart';

class BookProfileScreenBody extends StatefulWidget {
  BookModel? book;
  int bookId;
  BookProfileScreenBody({super.key, this.book, this.bookId = -1});

  @override
  State<BookProfileScreenBody> createState() {
    return _BookProfileScreenBodyState();
  }
}

class _BookProfileScreenBodyState extends State<BookProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late final ReviewPostController _reviewPostController;
  late final BookIdService _bookIdService;
  late final GetBookController _getBookController;
  late final HistoryService _historyService;
  late TabController _tabController;
  late ScrollController _scrollController;

  final List<String> _tabNames = ['Reviews', 'Locations', 'Read Online'];
  final double scrollThreshold = 300;
  bool _isWriting = false;
  double _rating = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _bookIdService = BookIdService();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _historyService = HistoryService(globalUser!.userId);
    if (widget.bookId != -1) {
      _getBookController = GetBookController(widget.bookId);
      _fetchBookDetails();
    } else {
      _fetchBookIdAndDetails();
    }
  }

  Future<void> _fetchBookIdAndDetails() async {
    try {
      final bookId = await _bookIdService.fetchId(widget.book!);
      setState(() {
        widget.bookId = bookId;
      });
      _getBookController = GetBookController(widget.bookId);
      await _fetchBookDetails();
    } catch (e) {
      print('Error fetching book ID and details: $e');
    }
  }

  Future<void> _fetchBookDetails() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final fetchedBook = await _getBookController.fetchBook();
      setState(() {
        widget.book = fetchedBook;
        _reviewPostController = ReviewPostController(widget.book!);
        _isLoading = false;
      });

      await _insertBookHistory();
    } catch (e) {
      print('Error fetching book details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _insertBookHistory() async {
    try {
      final token = await getToken(); // Fetch the token using getToken()
      if (widget.book != null && widget.bookId != -1) {
        await _historyService.insertBookHistory(token!, widget.bookId);
      } else {
        final bookId = await _bookIdService.fetchId(widget.book!);
        setState(() {
          widget.bookId = bookId;
        });
        await _historyService.insertBookHistory(token!, widget.bookId);
      }
    } catch (e) {
      print('Error inserting book history: $e');
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >= scrollThreshold &&
        !_scrollController.position.outOfRange) {
      _scrollController.jumpTo(scrollThreshold);
    }
  }

  void _increaseRating() {
    setState(() {
      if (_rating < 5.0) {
        _rating += 0.5; // Increment rating by 0.5
      }
    });
  }

  void _decreaseRating() {
    setState(() {
      if (_rating > 0.0) {
        _rating -= 0.5; // Decrement rating by 0.5
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
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
                  Center(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: BookProfileScreenDetails(book: widget.book!),
                        ),
                        SliverToBoxAdapter(
                          child: SelectionBar(
                            tabController: _tabController,
                            tabNames: _tabNames,
                          ),
                        ),
                        SliverFillRemaining(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              BookProfileScreenReviewListView(
                                screenName: 'Reviews',
                                book: widget.book!,
                              ), // Reviews
                              BookProfileScreenShopListView(
                                screenName: 'Locations',
                                book: widget.book!,
                              ), // Locations
                              BookProfileScreenShopListView(
                                screenName: 'Read Online',
                                book: widget.book!,
                              ), // Read Online
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16.0,
                    bottom: 16.0,
                    child: _isWriting
                        ? TextInputWidget(
                            controller:
                                _reviewPostController.reviewPostController,
                            rating: _rating,
                            hintText: 'Write your review here',
                            onSendPressed: () async {
                              setState(() {
                                _isWriting = false;
                              });
                              _reviewPostController.rating = _rating;
                              await _reviewPostController.reviewPost(context);
                            },
                            onIncreaseRating: _increaseRating,
                            onDecreaseRating: _decreaseRating,
                          )
                        : FloatingActionButtonWidget(
                            icon: Icon(Icons.add),
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
