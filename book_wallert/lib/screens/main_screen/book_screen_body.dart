import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/books_screen/books_list_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookScreenBody extends StatefulWidget {
  const BookScreenBody({super.key});

  @override
  State<BookScreenBody> createState() => _BooksScreenBodyState();
}

class _BooksScreenBodyState extends State<BookScreenBody> {
  Widget nextScreen = const BookListScreenBody();

  Widget setScreen(Widget screen) {
    setState(() {
      nextScreen = screen;
    });
    return nextScreen;
  }

  @override
  Widget build(BuildContext context) {
    setGlobalFunction(setScreen, 3);
    return nextScreen;
  }
}
