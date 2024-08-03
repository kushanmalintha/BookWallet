import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:flutter/material.dart';

class ReviewScreenListView extends StatelessWidget {
  final String screenName;
  final List<String> screens = [
    // name to screens
    'Comment',
    'Like',
    'Share',
  ];

  Widget getScreen(String screenName) {
    switch (screenName) {
      // functions to return a screen
      case 'Comment':
        return ReactUserCard(user: dummyUser);
      case 'Like':
        return ReactUserCard(user: dummyUser);
      case 'Share':
        return ReactUserCard(user: dummyUser);
    }
    return ReactUserCard(user: dummyUser);
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
