import 'package:book_wallert/controllers/share_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileTimeLineListView extends StatelessWidget {
  final int userId;

  const UserProfileTimeLineListView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShareController(),
      child: Consumer<ShareController>(
        builder: (context, shareController, child) {
          return FutureBuilder<List<ReviewModel>>(
            future: shareController.fetchUserTimeline(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<ReviewModel> reviews = snapshot.data!;
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: reviews[index]);
                  },
                );
              } else {
                return const Center(child: Text('No shared reviews found'));
              }
            },
          );
        },
      ),
    );
  }
}
