import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/groups_screen/groups_list_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupScreenBody extends StatefulWidget {
  const GroupScreenBody({super.key});

  @override
  State<GroupScreenBody> createState() => _GroupScreenBodyState();
}

class _GroupScreenBodyState extends State<GroupScreenBody> {
  Widget nextScreen = const GroupListScreenBody();

  Widget setScreen(Widget screen) {
    setState(() {
      nextScreen = screen;
    });
    return nextScreen;
  }

  @override
  Widget build(BuildContext context) {
    setGlobalFunction(setScreen, 2);
    return nextScreen;
  }
}
