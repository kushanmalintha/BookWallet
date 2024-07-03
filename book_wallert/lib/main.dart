import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/main_screen_frame.dart';

// The main entry point of the application.
void main() => runApp(const MyApp());

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // The main screen of the application.
      home: MainScreen(),

      // ...If need to add new different screen, uncomment below and edit...
      //Navigator.pushReplacementNamed(context, '/Profile'); call this function replacing the name

      // initialRoute: '/screenname1',
      // routes: { // adding routes
      //   '/screenname1': (context) => ScreenName1(),
      //   '/Profile': (context) => const ScreenName2(),
      // },
    );
  }
}
