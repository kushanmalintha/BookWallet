import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_details.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_list_view.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

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
  late TabController _tabController;
  late ScrollController _scrollController;

  final List<String> _tabNames = [
    'Reviews',
    'Locations',
    'Read Online',
  ];

  final double scrollThreshold = 300;
  bool _isWriting = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= scrollThreshold &&
        !_scrollController.position.outOfRange) {
      _scrollController.jumpTo(scrollThreshold);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
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
                            screenName: 'Reviews'), // Reviews
                        BookProfileScreenListView(
                            screenName: 'Locations'), // Locations
                        BookProfileScreenListView(
                            screenName: 'Read Online'), // Read Online
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
      child: const Icon(Icons.add),
    );
  }

  Widget _buildTextInput() {
    return GestureDetector(
      onTap: () {
        // Prevent the outer GestureDetector from closing the input
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        width: MediaQuery.of(context).size.width - 32.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: MyColors.panelColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: MyColors.bgColor,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  style: const TextStyle(color: MyColors.textColor),
                  controller: _textController,
                  maxLines: null,
                  onChanged: (text) {
                    setState(() {
                      // Adjust the height based on the content
                    });
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: MyColors.text2Color),
                    hintText: ('Write your review...'),
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                ),
              ),
            ),
            IconButton(
              color: MyColors.selectedItemColor,
              icon: const Icon(Icons.send),
              onPressed: () {
                // Handle send action
                print('Review sent: ${_textController.text}');
                _textController.clear();
                setState(() {
                  _isWriting = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
