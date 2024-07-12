import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/home_screen/home_list_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  Widget nextScreen = const HomeListScreenBody();

  Widget setScreen(Widget screen) {
    setState(() {
      nextScreen = screen;
    });
    return nextScreen;
  }

  @override
  Widget build(BuildContext context) {
    setGlobalFunction(setScreen, 1);
    return nextScreen;
  }
}
