import 'package:book_wallert/screens/test_screens/screen5/edit_user_info.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/main_screen/main_screen_frame.dart';
import 'package:book_wallert/screens/test_screens/test_screen_frame.dart';
import 'package:book_wallert/screens/test_screens/screen1/screen1.dart';
import 'package:book_wallert/screens/test_screens/screen2/screen2.dart';
import 'package:book_wallert/screens/test_screens/screen3/screen3.dart';
import 'package:book_wallert/screens/test_screens/screen4/screen4.dart';
import 'package:book_wallert/screens/test_screens/screen5/screen5.dart';
import 'package:book_wallert/screens/test_screens/screen6/screen6.dart';
import 'package:book_wallert/screens/test_screens/screen7/screen7.dart';
import 'package:book_wallert/screens/test_screens/screen8/screen8.dart';

// The main entry point of the application.
void main() => runApp(const MyApp());

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BookWallet",
      // The main screen of the application.
      // home: const MainScreen(),

      // ...If need to add new different screen, uncomment below and edit...
      //Navigator.pushReplacementNamed(context, '/Profile'); call this function replacing the name

      // initialRoute: '/screenname1',
      // routes: { // adding routes
      //   '/screenname1': (context) => ScreenName1(),
      //   '/Profile': (context) => const ScreenName2(),
      // },

      // or you can use
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateData()));
      // as the function to the button click at any place

      initialRoute: '/MainScreen',

      routes: {
        // adding routes
        '/MainScreen': (context) => const MainScreen(),
        '/TestScreen': (context) => const TestScreen(),
        '/screen1': (context) => const Screen1(),
        '/screen2': (context) => const Screen2(),
        '/screen3': (context) => const Screen3(),
        '/screen4': (context) => const Screen4(),
        '/screen5': (context) => const Screen5(),
        '/screen6': (context) => const Screen6(),
        '/screen7': (context) => const Screen7(),
        '/screen8': (context) => const Screen8(),
        '/EditUserInfo': (context) => const EditUserInfo(),
      },
    );
  }
}
