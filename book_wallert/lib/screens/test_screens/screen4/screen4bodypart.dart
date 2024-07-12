import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_list_veiw.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() {
    // returns a screen as state
    return _ProfileScreenBodyState();
  }
}

class _ProfileScreenBodyState extends State<ProfileScreenBody>
    with SingleTickerProviderStateMixin {
  // ''with ticker'' is to make sure connnection between clicking and swiping
  late TabController _tabController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Reviews',
    'Locations',
    'Read Online',
    //'Completed',
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
      // making the screen body
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: MyColors.bgColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: // adding the selection bar widget
              SelectionBar(tabController: _tabController, tabNames: _tabNames),
        ),
      ),
      body: TabBarView(
        // adding corrosponding screens to each button on SelectionBar.
        controller: _tabController,
        children: const [
          UserProfileListVeiw(screenName: 'Reviews'), // Recommended
          UserProfileListVeiw(screenName: 'Reading'), // Trending
          UserProfileListVeiw(screenName: 'Wishlist'), // Wishlist
          //ProfileListVeiw(screenName: 'Completed'), // Completed
        ],
      ),
    );
  }
}
