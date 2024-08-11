import 'package:flutter/material.dart';

class FullScreenToggle extends StatelessWidget {
  final VoidCallback onPressed;

  const FullScreenToggle({super.key, required this.onPressed, required bool isFullScreen});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        foregroundColor: const Color.fromARGB(255, 155, 242, 144),
        backgroundColor: const Color.fromARGB(113, 114, 115, 113),
        mini: true,
        onPressed: onPressed,
        child: const Icon(Icons.fullscreen_exit),
      ),
    );
  }
}
