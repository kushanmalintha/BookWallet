import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/cards/review_card2.dart';
import 'package:flutter/material.dart';

class BookProfileScreenListView extends StatefulWidget {
  final String screenName;
  final BookModel book;

  const BookProfileScreenListView(
      {super.key, required this.screenName, required this.book});

  @override
  State<BookProfileScreenListView> createState() =>
      _BookProfileScreenListViewState();
}

class _BookProfileScreenListViewState extends State<BookProfileScreenListView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final List<String> screens = [
    'Reviews',
    'Locations',
    'Read online',
  ];

  @override
  bool get wantKeepAlive => true;

  Widget getScreen(String screenName) {
    switch (screenName) {
      case 'Reviews':
        return ReviewCard();
      case 'Locations':
      case 'Read Online':
      //return LocationsCard();
      default:
        return BookCard(book: dummyBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      controller: _scrollController,
      itemCount: 10,
      itemBuilder: (context, index) {
        return getScreen(widget.screenName);
      },
    );
  }
}
