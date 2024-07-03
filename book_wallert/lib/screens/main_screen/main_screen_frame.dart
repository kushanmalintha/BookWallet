import 'package:book_wallert/screens/main_screen/groups_screen/groups_screen_body.dart';
import 'package:book_wallert/screens/main_screen/profile_screen/profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/main_screen/top_panel.dart';
import 'package:book_wallert/screens/main_screen/home_screen/home_screen_body.dart';
import 'package:book_wallert/screens/main_screen/books_screen/books_screen_body.dart';

// The main screen of the application, which is stateful.
class MainScreen extends StatefulWidget {
  // since we change the UI we have to use StateFulWidget
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() {
    // returns a Screen state
    return _MainScreenState();
  }
}

// The state for the HomeScreen widget.
class _MainScreenState extends State<MainScreen> {
  // Index for the selected bottom navigation bar item.
  int _selectedIndex = 0; // starting from Home

  // Handle bottom navigation bar item tap.
  void _onItemTapped(int index) {
    setState(() {
      // to tell refresh the screen(calling the build function), we call using this function
      _selectedIndex = index; // updating the index
    });
  }

  @override
  Widget build(BuildContext context) {
    // keeping the active page
    Widget? activePage;

    // page name
    var pageName = 'Book Wallet';

    switch (_selectedIndex) {
      // updating the screeen body
      case 0:
        pageName = 'Book Wallet';
        activePage = const HomeScreenBody();
        break;
      case 1:
        pageName = 'Groups';
        activePage = const GroupScreenBody();
        break;
      case 2:
        pageName = 'Books';
        activePage = const BooksScreenBody();
        break;
      case 3:
        pageName = "Profile";
        activePage = const ProfileScreenBody();
    }

    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        // Title of the AppBar.
        title: TopPanel(title: pageName),
      ),
      // changing the body of the app screen
      body: activePage,
      // BottomNavigationBar with 4 items.
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        backgroundColor: MyColors.navigationBarColor,
        unselectedItemColor: MyColors.nonSelectedItemColor,
        selectedItemColor: MyColors.selectedItemColor,
        currentIndex: _selectedIndex, // changin the colors to the selected icon
        onTap: _onItemTapped, // calling the function with the tapped icon index
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
