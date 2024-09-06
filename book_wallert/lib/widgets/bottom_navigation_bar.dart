import 'package:book_wallert/screens/reading_books_screen/my_readings_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSlideUpdate(DragUpdateDetails details) {
    // Update the animation value based on the drag amount
    _animationController.value -= details.primaryDelta! / 300.0;
  }

  void _handleSlideEnd(DragEndDetails details) {
    if (_animationController.value > 0.5) {
      _animationController.forward();
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyReadingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          backgroundColor: MyColors.navigationBarColor,
          unselectedItemColor: MyColors.nonSelectedItemColor,
          selectedItemColor: MyColors.selectedItemColor,
          currentIndex: widget.selectedIndex,
          onTap: widget.onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(width: 0), // Spacer item, effectively invisible
              label: '', // No label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        Positioned(
          top:
              -10, // Adjust this value to control the vertical position of the button
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
            onVerticalDragUpdate: _handleSlideUpdate,
            onVerticalDragEnd: _handleSlideEnd,
            child: FloatingActionButton(
              onPressed: () {
                // Animate directly to the end if clicked
                _animationController.forward();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MyReadingsScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var tween =
                          Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.menu_book,
                color: MyColors.nonSelectedItemColor,
              ),
              backgroundColor: MyColors.navigationBarColor,
            ),
          ),
        ),
      ],
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
    );
  }
}
