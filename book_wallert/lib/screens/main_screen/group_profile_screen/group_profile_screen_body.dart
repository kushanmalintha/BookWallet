import 'package:book_wallert/dummy_data/group_dummy_data.dart';
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
  late ScrollController _scrollController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Reviews',
    'Books',
  ];
  // Set a scroll threshold
  final double scrollThreshold = 100;

  @override
  void initState() {
    // Tab controller
    super.initState();
    _tabController = TabController(
        length: _tabNames.length,
        vsync: this); // animation details are mentioned here

    // Scroll controller
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
            child: GroupProfileScreenDetails(group: dummyGroup),
          ),
          SliverToBoxAdapter(
            child: SelectionBar(
                tabController: _tabController, tabNames: _tabNames),
          ),
          SliverFillRemaining(
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
