import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/main_screen/search_screens/search_screen_body.dart';
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
  int _selectedIndex = 0;
  bool _refreshCurrentScreen = false;

  final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _bookNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _groupNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _profileNavigatorKey =
      GlobalKey<NavigatorState>();

  final List<Widget> _screens = [
    const HomeListScreenBody(),
    BookListScreenBody(userId: globalUser!.userId),
    GroupListScreenBody(globalUserId: globalUser!.userId),
    UserProfileScreenBody(userId: globalUser!.userId),
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [];

  @override
  void initState() {
    super.initState();
    _navigatorKeys.addAll([
      _homeNavigatorKey,
      _bookNavigatorKey,
      _groupNavigatorKey,
      _profileNavigatorKey,
    ]);
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      return; // Ignore taps on index 2 (the Groups button)
    }

    int newIndex = index > 2 ? index - 1 : index;

    if (_selectedIndex == newIndex) {
      // Ensure only work in the second tap
      _refreshCurrentScreen = true;
    } else {
      _refreshCurrentScreen = false; // Reset refresh flag when switching tabs
    }

    setState(() {
      _selectedIndex = newIndex;
    });

    // If coming back to Home and it's already displayed, pop to it instead of recreating
    if (_selectedIndex == newIndex && _refreshCurrentScreen) {
      // Check if there's a previous route to pop
      if (_navigatorKeys[_selectedIndex].currentState!.canPop()) {
        _navigatorKeys[_selectedIndex]
            .currentState!
            .popUntil((route) => route.isFirst);
      } else {
        // add here any logic if need to re-create a new refresh(re-create the content) 
      }
    }
  }

  void _searchBooks(String searchText) {
    _navigatorKeys[_selectedIndex].currentState!.push(
          MaterialPageRoute(
            builder: (context) => SearchScreenBody(searchText: searchText),
          ),
        );
  }

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
        return 'BookWallet';
    }
  }

  Future<bool> _onWillPop() async {
    final NavigatorState navigator =
        _navigatorKeys[_selectedIndex].currentState!;
    if (navigator.canPop()) {
      navigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: TopPanel(
        title: _getName(_selectedIndex),
        searchTrigger: _searchBooks,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _homeNavigatorKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _screens[0],
                );
              },
            ),
          ),
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _bookNavigatorKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _screens[1],
                );
              },
            ),
          ),
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _groupNavigatorKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _screens[2],
                );
              },
            ),
          ),
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _profileNavigatorKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _screens[3],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex:
            _selectedIndex >= 2 ? _selectedIndex + 1 : _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
