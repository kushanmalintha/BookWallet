import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onClose;

  const FullScreenImage({required this.imageUrl, required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
