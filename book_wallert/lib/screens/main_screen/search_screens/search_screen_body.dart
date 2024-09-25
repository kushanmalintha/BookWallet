import 'package:book_wallert/screens/main_screen/search_screens/book_search_listview.dart';
import 'package:book_wallert/screens/main_screen/search_screens/group_search_listview.dart';
import 'package:book_wallert/screens/main_screen/search_screens/user_search_listview.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';

class SearchScreenBody extends StatefulWidget {
  final String searchText;

  const SearchScreenBody({super.key, required this.searchText});

  @override
  State<SearchScreenBody> createState() {
    // returns a screen as state
    return _SearchScreenBodyState();
  }
}

class _SearchScreenBodyState extends State<SearchScreenBody>
    with SingleTickerProviderStateMixin {
  // ''with ticker'' is to make sure connnection between clicking and swiping
  late TabController _tabController;

  // add name to buttons on panel
  final List<String> _tabNames = [
    'Books',
    'Users',
    'Groups',
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
        children: [
          BookSearchListview(searchText: widget.searchText),
          UserSearchListview(searchText: widget.searchText),
          GroupSearchListview(searchText: widget.searchText),
        ],
      ),
    );
  }
}
