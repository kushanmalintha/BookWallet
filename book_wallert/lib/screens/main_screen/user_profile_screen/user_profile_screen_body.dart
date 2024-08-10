import 'package:book_wallert/controllers/user_profile_controller.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/models/user_profile_model.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_completed_list_view.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_review_list_view.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_wishlist_list_view.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_details.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_list_veiw.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class UserProfileScreenBody extends StatefulWidget {
  final int userId;
  // user model
  UserProfileModel? userProfile;

  UserProfileScreenBody({super.key, required this.userId, this.userProfile});

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
  late UserProfileModel _user;

  final List<String> _tabNames = [
    'Reviews',
    'Reading',
    'Wishlist',
    'Completed',
  ];

  final double scrollThreshold = 330;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _getUserProfileController = GetUserProfileController(widget.userId);
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    UserProfileModel fetchedUserProfile =
        await _getUserProfileController.fetchUserProfile();
    setState(() {
      _user = fetchedUserProfile;
    });
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: UserProfileDetails(
                user: dummyUser,
                userProfile: widget.userProfile), // Top details section
          ),
          SliverToBoxAdapter(
            child: SelectionBar(
                tabController: _tabController, tabNames: _tabNames),
          ),
          SliverFillRemaining(
            child: TabBarView(
              // adding corresponding screens to each button on SelectionBar.
              controller: _tabController,
              children: [
                UserProfileReviewListView(userId: widget.userId), // Reviews
                const UserProfileListVeiw(screenName: 'Reading'), // Reading
                UserProfileWishlistListView(userId: widget.userId), // Wishlist
                UserProfileCompletedListView(
                    userId: widget.userId), // Completed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
