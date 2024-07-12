import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_list_view.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class GroupProfileScreenBody extends StatefulWidget {
  const GroupProfileScreenBody({super.key});

  @override
  State<GroupProfileScreenBody> createState() {
    // returns a screen as state
    return _GroupProfileScreenBodyState();
  }
}

class _GroupProfileScreenBodyState extends State<GroupProfileScreenBody>
    with SingleTickerProviderStateMixin {
  // ''with ticker'' is to make sure connnection between clicking and swiping
  late TabController _tabController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Reviews',
    'Books',
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
          const GroupProfileScreenDetails(),
          SelectionBar(tabController: _tabController, tabNames: _tabNames),
          Expanded(
            child: TabBarView(
              // adding corresponding screens to each button on SelectionBar.
              controller: _tabController,
              children: const [
                GroupProfileScreenListView(screenName: 'Reviews'), // Reviews
                GroupProfileScreenListView(screenName: 'Books'), // Books
              ],
            ),
          ),
        ],
      ),
    );
  }
}
