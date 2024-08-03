import 'package:flutter/material.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/controllers/review_post_controller.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_details.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_list_view.dart';
import 'package:book_wallert/widgets/cards/rating_bar.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';
import 'package:book_wallert/colors.dart';

class BookProfileScreenBody extends StatefulWidget {
  final BookModel book;
  const BookProfileScreenBody({super.key, required this.book});

  @override
  State<BookProfileScreenBody> createState() {
    return _BookProfileScreenBodyState();
  }
}

class _BookProfileScreenBodyState extends State<BookProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late final ReviewPostController _reviewPostController;
  late TabController _tabController;
  late ScrollController _scrollController;

  final List<String> _tabNames = [
    'Reviews',
    'Locations',
    'Read Online',
  ];

  final double scrollThreshold = 300;
  bool _isWriting = false;
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _reviewPostController =
        ReviewPostController(widget.book); // Initialize with the current book
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
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: GestureDetector(
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
                    child: BookProfileScreenDetails(book: widget.book),
                  ),
                  SliverToBoxAdapter(
                    child: SelectionBar(
                        tabController: _tabController, tabNames: _tabNames),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BookProfileScreenListView(
                            screenName: 'Reviews',
                            book: widget.book), // Reviews
                        BookProfileScreenListView(
                            screenName: 'Locations',
                            book: widget.book), // Locations
                        BookProfileScreenListView(
                            screenName: 'Read Online',
                            book: widget.book), // Read Online
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child:
                  _isWriting ? _buildTextInput() : _buildFloatingActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: MyColors.selectedItemColor,
      onPressed: () {
        setState(() {
          _isWriting = true;
        });
      },
      child: const Icon(
        Icons.add,
        color: MyColors.bgColor,
      ),
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
                const SizedBox(
                    height: 40), // Adding space for the widgets at the top
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: MyColors.textColor),
                        controller: _reviewPostController.reviewPostController,
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
                        setState(() {
                          _isWriting = false;
                        });
                        _reviewPostController.rating =
                            _rating; // Set the rating
                        _reviewPostController.reviewPost(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 8,
            child: RatingBar(rating: _rating),
          ),
          Positioned(
            right: 50, // Adjust left position to avoid overlap
            child: IconButton(
                onPressed: _increaseRating,
                icon: const Icon(Icons.add),
                color: MyColors.nonSelectedItemColor),
          ),
          Positioned(
            right: 5, // Adjust left position to avoid overlap
            child: IconButton(
                onPressed: _decreaseRating,
                icon: const Icon(Icons.remove),
                color: MyColors.nonSelectedItemColor),
          ),
        ],
      ),
    );
  }
}
