import 'package:book_wallert/controllers/share_controller.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/frames/shareby_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileTimeLineListView extends StatelessWidget {
  final int userId;

  const UserProfileTimeLineListView({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserActivityController(userId),
      child: Consumer<UserActivityController>(
        builder: (context, controller, _) {
          print('$userId');
          print(controller.userActivities);
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.userActivities.length,
                  itemBuilder: (context, index) {
                    final activity = controller.userActivities[index];

                    if (activity is SharedReview) {
                      return SharedByCard(
                        child: ReviewCard(review: activity.review),
                        sharedBy: [activity.sharerUsername],
                        imagePath: dummyUser.imageUrl,
                        userId: activity.sharedUserId,
                      );
                    } else if (activity is ReviewModel) {
                      return ReviewCard(review: activity);
                    } else {
                      return SizedBox
                          .shrink(); // For safety, in case of unexpected data
                    }
                  },
                );
        },
      ),
    );
  }
}
