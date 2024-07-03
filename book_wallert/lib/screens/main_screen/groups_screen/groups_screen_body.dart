import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/groups_screen/groups_list_view.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/buttons/selection_bar.dart';

class GroupScreenBody extends StatefulWidget {
  const GroupScreenBody({super.key});

  @override
  State<GroupScreenBody> createState() {
    // returns a screen as state
    return _GroupScreenBodyState();
  }
}

class _GroupScreenBodyState extends State<GroupScreenBody>
    with SingleTickerProviderStateMixin {
  // ''with ticker'' is to make sure connnection between clicking and swiping
  late TabController _tabController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Your fandoms',
    'Trending',
    'Suggestions',
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
          Groups_list_view(), // Your fandoms
          Groups_list_view(), // Trending
          Groups_list_view(), // Suggestions
        ],
      ),
    );
  }
}
