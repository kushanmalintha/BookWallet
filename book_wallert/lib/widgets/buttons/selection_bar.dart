import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class SelectionBar extends StatelessWidget {
  final TabController
      tabController; // this controller take care of switching between horizontal views
  final List<String>
      tabNames; // This list contains names for buttons in the panle

  const SelectionBar(
      // constructor
      {super.key,
      required this.tabController,
      required this.tabNames});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      // returns the tab bar widget
      tabAlignment: TabAlignment.start, // alignment start from left side
      labelStyle: const TextStyle(fontSize: 13), // text size
      isScrollable: true, // scrollable state
      labelColor: MyColors.selectedItemColor, // text colour when selected
      unselectedLabelColor:
          MyColors.nonSelectedItemColor, // text color when not selected
      splashBorderRadius: BorderRadius.circular(50), // roundness of the button
      indicatorColor: MyColors.selectedItemColor, // below line color
      controller: tabController, // making contollers equal
      tabs: tabNames
          .map((tabName) => Tab(text: tabName))
          .toList(), // creating buttons with given names
    );
  }
}
