import 'package:book_wallert/dummy_data/group_dummy_data.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_suggestion.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_trending.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_yourgroup.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class GroupsListViewFandom extends StatelessWidget {
  const GroupsListViewFandom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return GroupCardYourgroup(group: dummyGroup);
        },
      ),
    );
  }
}

class GroupsListViewSuggestion extends StatelessWidget {
  const GroupsListViewSuggestion({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return GroupCardYourgroup(group: dummyGroup);
        },
      ),
    );
  }
}

class GroupsListViewTrending extends StatelessWidget {
  const GroupsListViewTrending({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: ListView(
        children: [
          GroupCardTrending(
            rank: 1,
            group: dummyGroup,
          ),
          GroupCardTrending(
            rank: 2,
            group: dummyGroup,
          ),
          GroupCardTrending(
            rank: 3,
            group: dummyGroup,
          ),
          GroupCardTrending(
            rank: 4,
            group: dummyGroup,
          ),
        ],
      ),
    );
  }
}
