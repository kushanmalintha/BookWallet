import 'package:book_wallert/widgets/cards/react_user_card.dart';
import 'package:flutter/material.dart';

class ReviewScreenListView extends StatelessWidget {
  final String screenName;
  final List<String> screens = [
    // name to screens
    'Like',
    'Comment',
    'Share',
  ];

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Like':
        return ReactUserCard();
      case 'Comment':
        return ReactUserCard();
      case 'Share':
        return ReactUserCard();
    }
    return ReactUserCard();
  }

  ReviewScreenListView({super.key, required this.screenName});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Number of items in the list.
      itemCount: 10, // Change this to the number of books
      // Builder function for each list item.
      itemBuilder: (context, index) {
        return getScreen(screenName); //
      },
    );
  }
}
