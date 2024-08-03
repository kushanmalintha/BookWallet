import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/search_screens/search_list_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/books_screen/books_list_screen_body.dart';
import 'package:book_wallert/screens/main_screen/groups_screen/groups_list_screen_body.dart';
import 'package:book_wallert/screens/main_screen/home_screen/home_list_screen_body.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:book_wallert/widgets/top_panel.dart';
import 'package:book_wallert/widgets/bottom_navigation_bar.dart';
import 'package:book_wallert/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Current index of the selected tab in the bottom navigation bar
  int _selectedIndex = 0;

  // Key for the Navigator to manage the stack of pages
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // Method to handle bottom navigation bar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
    );
  }

  void _searchBooks(String searchText) {
    // Navigate to BookProfileScreenBody when the card is tapped
    setState(() {});
    _navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => IndexedStack(
          index: 0,
          children: [SearchListScreenBody(searchText: searchText)],
        ),
      ),
    );
  }

  // List of screens to display based on the selected index
  List<Widget> screens = const [
    HomeListScreenBody(),
    BookListScreenBody(globalUserId: 1,),
    GroupListScreenBody(globalUserId: 1,),
    UserProfileScreenBody(userId: 1,),
  ];

  // Method to get the title of the current screen based on the selected index
  String _getName(int index) {
    switch (index) {
      case 0:
        return 'BookWallet';
      case 1:
        return 'Books';
      case 2:
        return 'Groups';
      case 3:
        return 'Profile';
      default:
        return 'BookWallet'; // Default to HomeListScreenBody
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: TopPanel(
        title: _getName(_selectedIndex),
        searchTrigger: _searchBooks, // Top panel with dynamic title
      ),
      body: PopScope(
        canPop: false, // Disable popping from the stack
        onPopInvoked: (didPop) async {
          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
          }
        },
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) =>
                  screens[_selectedIndex], // Display the selected screen
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Handle bottom navigation bar taps
      ),
    );
  }
}
