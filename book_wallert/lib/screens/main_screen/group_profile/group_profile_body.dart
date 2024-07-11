import 'package:book_wallert/screens/main_screen/group_profile/group_profile_list_view.dart';
import 'package:book_wallert/screens/main_screen/group_profile/group_profile_toppanel.dart';
import 'package:book_wallert/screens/main_screen/top_panel.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/buttons/selection_bar.dart';

class GroupProfileBody extends StatefulWidget {
  const GroupProfileBody({super.key});

  @override
  State<GroupProfileBody> createState() {
    // returns a screen as state
    return _GroupProfileBodyState();
  }
}

class _GroupProfileBodyState extends State<GroupProfileBody>
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
      // making the screen body
      backgroundColor: MyColors.bgColor,
      appBar: const TopPanel(title: 'Fandoms'),
      body: Column(
        children: [
          const GroupProfileTopPanel(),
          // adding the selection bar widget outside the app bar
          SelectionBar(tabController: _tabController, tabNames: _tabNames),
          Expanded(
            child: TabBarView(
              // adding corresponding screens to each button on SelectionBar.
              controller: _tabController,
              children: const [
                GroupProfileListView(), // Reviews
                GroupProfileListView(), // Books
              ],
            ),
          ),
        ],
      ),
    );
  }
}
