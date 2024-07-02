import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/book_list_view.dart';
import 'package:book_wallert/main.dart';
import 'package:book_wallert/custom_button.dart';
import 'package:book_wallert/top_panel.dart';

// The state for the HomeScreen widget.
class BooksScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Index for the selected bottom navigation bar item.
  int _selectedIndex = 2;
  // Controller for the TabBar.
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 4 tabs.
    _tabController = TabController(length: 4, vsync: this);
  }

  // Handle bottom navigation bar item tap.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/groups');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        // Title of the AppBar.
        title: const TopPanel(title: 'Book'),
        // // TabBar with 4 tabs.
        bottom: TabBar(
          isScrollable: false,
          labelColor: MyColors.selectedItemColor,
          unselectedLabelColor: MyColors.nonSelectedItemColor,
          splashBorderRadius: BorderRadius.circular(100),
          indicatorColor: MyColors.selectedItemColor,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recommended'),
            Tab(text: 'Trending'),
            Tab(text: 'Wishlist'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      // TabBarView with 4 corresponding views.
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomToggleButton(text: 'Recommended'),
              SizedBox(width: 10),
              CustomToggleButton(text: 'Trending'),
              SizedBox(width: 10),
              CustomToggleButton(text: 'Wishlist'),
              SizedBox(width: 10),
              CustomToggleButton(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                BookListView(),
                BookListView(),
                BookListView(),
                BookListView(),
              ],
            ),
          ),
        ],
      ),
      // BottomNavigationBar with 4 items.
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        backgroundColor: MyColors.navigationBarColor,
        unselectedItemColor: MyColors.nonSelectedItemColor,
        selectedItemColor: MyColors.selectedItemColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
