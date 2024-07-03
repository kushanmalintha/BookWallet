import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  final List<String> buttonIndex = [
    '/screen1',
    '/screen2',
    '/screen3',
    '/screen4',
    '/screen5',
    '/screen6',
    '/screen7',
    '/screen8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Test Screens',
          style: TextStyle(color: MyColors.text2Color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(8, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, buttonIndex[index]);
                },
                child: Text('Screen ${index + 1}'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
