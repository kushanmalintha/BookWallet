import 'package:book_wallert/colors.dart';
import 'package:book_wallert/dummy_data/group_dummy_data.dart';
import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:book_wallert/screens/test_screens/screen5/shareby_frame.dart';
import 'package:book_wallert/screens/test_screens/screen5/trendingwidget_frame.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_suggestion.dart';
import 'package:flutter/material.dart';

class Screen5 extends StatelessWidget {
  const Screen5({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView(
        children: [
          RankedCard(
            rank: 1,
            child: GroupCardSuggestion(
              group: dummyGroup,
            ),
          ),
          RankedCard(
            rank: 2,
            child: GroupCardSuggestion(
              group: dummyGroup,
            ),
          ),
          RankedCard(
            rank: 3,
            child: GroupCardSuggestion(
              group: dummyGroup,
            ),
          ),
          RankedCard(
            rank: 4,
            child: GroupCardSuggestion(
              group: dummyGroup,
            ),
          ),
          SharedByCard(
            sharedBy: dummyReview.reviwerName,
            imagePath: dummyReview.imagePath,
            child: GroupCardSuggestion(
              group: dummyGroup,
            ),
          )
        ],
      ),
    );
  }
}
