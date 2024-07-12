import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_list_veiw.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({super.key});

  @override
  State<UserProfileScreenBody> createState() {
    // returns a screen as state
    return _UserProfileScreenBodyState();
  }
}

class _UserProfileScreenBodyState extends State<UserProfileScreenBody>
    with SingleTickerProviderStateMixin {
  // ''with ticker'' is to make sure connnection between clicking and swiping
  late TabController _tabController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Reviews',
    'Reading',
    'Wishlist',
    'Completed',
  ];

  @override
  void initState() {
    // Tab controller
    super.initState();
    _tabController = TabController(
        length: _tabNames.length,
        vsync: this); // animation details are mentioned here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Column(
        children: [
          const UserProfileDetails(), // Top details section
          SelectionBar(tabController: _tabController, tabNames: _tabNames),
          Expanded(
            child: TabBarView(
              // adding corrosponding screens to each button on SelectionBar.
              controller: _tabController,
              children: const [
                UserProfileListVeiw(screenName: 'Reviews'), // Recommended
                UserProfileListVeiw(screenName: 'Reading'), // Trending
                UserProfileListVeiw(screenName: 'Wishlist'), // Wishlist
                UserProfileListVeiw(screenName: 'Completed'), // Completed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
