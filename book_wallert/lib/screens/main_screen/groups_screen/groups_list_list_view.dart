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
          return const FandomCard(
            groupName: 'Harry potter fans',
            memberCount: '10499',
            discussionCount: 400,
          );
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
          return const SuggestionCard();
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
        children: const [
          TrendingCard(rank: 1),
          TrendingCard(rank: 2),
          TrendingCard(rank: 3),
          TrendingCard(rank: 4),
        ],
      ),
    );
  }
}
