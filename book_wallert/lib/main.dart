import 'package:flutter/material.dart';
// import 'package:book_wallert/colors.dart';
// import 'package:book_wallert/bookListView.dart';
import 'package:book_wallert/book_screen_state.dart';
import 'groups_screen.dart';
import 'home_screen.dart';

// The main entry point of the application.
void main() => runApp(const MyApp());

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // The main screen of the application.
      home: const HomeScreen(),
      routes: {
        '/groups': (context) => GroupsScreen(),
        '/home': (context) => const HomeScreen1(),
      },
    );
  }
}

// The main screen of the application, which is stateful.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  BooksScreenState createState() => BooksScreenState();
}
