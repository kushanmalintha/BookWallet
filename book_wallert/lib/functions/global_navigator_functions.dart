import 'package:flutter/material.dart';

Future<void> screenChange(BuildContext context, Widget newBody) {
  return Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => newBody),
  );
}

class ScreenChange {
  static Future<void> screenChange(BuildContext context, Widget newBody) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => newBody),
    );
  }
}
