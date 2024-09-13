import 'package:flutter/material.dart';
import 'package:book_wallert/screens/barcode_scanner_screen/barcode_scanning_screen.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
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
    print('Searching for: $searchText');
    widget.searchTrigger(searchText);
    setState(() {
      _isSearching = false;
    });
  }

  Future<void> _scanBarcode() async {
    final isbn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerSimple(),
      ),
    );
    if (isbn is String && isbn.isNotEmpty) {
      final searchText = 'isbn:$isbn';
      _searchController.text = searchText;
      _handleSearch();
    }
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
        foregroundColor: MyColors.navigationBarColor,
        scrolledUnderElevation: 0,
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
                onSubmitted: (query) {
                  _handleSearch(); // Call the search function
                },
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSearching
                ? Row(
                    key: const ValueKey('searching'),
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: MyColors.nonSelectedItemColor,
                        onPressed: _handleSearch,
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        color: MyColors.nonSelectedItemColor,
                        onPressed: _scanBarcode, // Trigger the barcode scanner
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: MyColors.nonSelectedItemColor,
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                            _searchController.clear();
                          });
                        },
                      ),
                    ],
                  )
                : Row(
                    key: const ValueKey('notSearching'),
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: MyColors.nonSelectedItemColor,
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                      ),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: _isSearching
                            ? const Offset(1, 0)
                            : const Offset(0, 0),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_rounded),
                          color: MyColors.nonSelectedItemColor,
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(
                                  context, '/NotificationsScreen');
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          CustomPopupMenuButtons(
            items: const ['Test Screens', 'Settings', 'History', 'Saved'],
            onItemTap: [
              () {
                Navigator.pushNamed(context, '/TestScreen');
              },
              () {
                Navigator.pushNamed(context, '/SettingsScreen');
              },
              () {
                Navigator.pushNamed(context, '/HistoryScreen');
              },
              () {
                Navigator.pushNamed(context, '/SaveScreen');
              },
            ],
            icon: const Icon(
              Icons.menu,
              color: MyColors.nonSelectedItemColor,
            ),
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
