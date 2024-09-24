import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/share_controller.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/frames/shareby_frame.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileTimeLineListView extends StatefulWidget {
  final int userId;

  const UserProfileTimeLineListView({Key? key, required this.userId})
      : super(key: key);

  @override
  State<UserProfileTimeLineListView> createState() =>
      _UserProfileTimeLineListViewState();
}

class _UserProfileTimeLineListViewState
    extends State<UserProfileTimeLineListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late UserActivityController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserActivityController(widget.userId);
  }

  Future<void> _onRefresh() async {
    setState(() {
      _controller.userActivities = [];
    });
    await _controller.fetchUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // This is required for keepAlive to work

    return ChangeNotifierProvider(
      create: (_) => _controller,
      child: Consumer<UserActivityController>(
        builder: (context, controller, _) {
          return RefreshIndicator(
            color: MyColors.selectedItemColor,
            backgroundColor: MyColors.bgColor,
            onRefresh: _onRefresh,
            child: controller.isLoading
                ? Center(child: buildProgressIndicator())
                : controller.userActivities.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: const Center(
                              child: Text(
                                'No user activities',
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
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
                            return const SizedBox.shrink(); // Safety check
                          }
                        },
                      ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
