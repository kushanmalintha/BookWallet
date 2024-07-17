import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class TopPanel extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function searchTrigger;

  const TopPanel({super.key, required this.title, required this.searchTrigger});

  @override
  State<TopPanel> createState() => _TopPanelState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopPanelState extends State<TopPanel> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch() {
    final searchText = _searchController.text;
    // Handle the search action with searchText
    print('Searching for: $searchText');
    widget.searchTrigger(searchText);
    // You can add your search logic here, like updating the UI or fetching data
    setState(() {
      _isSearching = false;
    });
  }

  Future<bool> _popScope() async {
    if (_isSearching) {
      setState(() {
        _isSearching = true;
        _searchController.clear();
      });
      return false; // Prevents the default back navigation
    }
    return true; // Allows the default back navigation
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disable popping from the stack
      onPopInvoked: (didPop) async {
        _popScope();
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.navigationBarColor,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: MyColors.titleColor),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: MyColors.nonSelectedItemColor),
                  border: InputBorder.none,
                ),
              )
            : Text(
                widget.title,
                style: const TextStyle(
                  color: MyColors.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              color: MyColors.nonSelectedItemColor,
              onPressed: _handleSearch,
            ),
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            color: MyColors.nonSelectedItemColor,
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
          PopupMenuButton<String>(
            elevation: 10,
            shadowColor: MyColors.bgColor,
            color: MyColors.nonSelectedItemColor,
            icon: const Icon(
              Icons.menu,
              color: MyColors.nonSelectedItemColor,
            ),
            onSelected: (String result) {
              // Handle menu item selections
              if (result == 'Test Screens') {
                Navigator.pushNamed(context, '/TestScreen');
              } else if (result == 'Settings') {
                Navigator.pushNamed(context, '/SettingsScreen');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Test Screens',
                child: Text('Test Screens'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
