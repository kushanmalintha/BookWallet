import 'package:book_wallert/controllers/user_profile_controller.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/screens/main_screen/books_screen/book_whislist_listview.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_completed_list_view.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_review_list_view.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_timeline_list_view.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_details.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_list_veiw.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class UserProfileScreenBody extends StatefulWidget {
  final int userId;

  const UserProfileScreenBody({super.key, required this.userId});

  @override
  State<UserProfileScreenBody> createState() {
    return _UserProfileScreenBodyState();
  }
}

class _UserProfileScreenBodyState extends State<UserProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late GetUserProfileController _getUserProfileController;

  final List<String> _tabNames = [
    'Timeline',  // New Timeline Tab
    'Reviews',
    'Reading',
    'Wishlist',
    'Completed',
  ];

  final double scrollThreshold = 330;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);  // Updated length
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _getUserProfileController = GetUserProfileController(widget.userId);
  }

  void _scrollListener() {
    if (_scrollController.offset >= scrollThreshold &&
        !_scrollController.position.outOfRange) {
      _scrollController.jumpTo(scrollThreshold);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: FutureBuilder<User>(
        future: _getUserProfileController.fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: buildProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: UserProfileDetails(user: user),
                ),
                SliverToBoxAdapter(
                  child: SelectionBar(
                      tabController: _tabController, tabNames: _tabNames),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      UserProfileTimeLineListView(userId: widget.userId), 
                      UserProfileReviewListView(userId: widget.userId),
                      const UserProfileListVeiw(screenName: 'Reading'),
                      BookWishlistListView(userId: widget.userId),
                      UserProfileCompletedListView(userId: widget.userId),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('User not found'));
          }
        },
      ),
    );
  }
}
