import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.panelColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.menu,
              color: MyColors.nonSelectedItemColor,
            ),
            onSelected: (String result) {
              // Handle menu item selections
              if (result == 'Settings') {
                // navigate settings page
              }
              // other menu items like this
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
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
}
