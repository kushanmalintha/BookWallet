import 'package:flutter/material.dart';

class BookReadingProgressBar extends StatefulWidget {
  final Widget child;
  final double progress; // Value between 0 and 1

  const BookReadingProgressBar({
    super.key,
    required this.child,
    this.progress = 0,
  }) : assert(progress >= 0 && progress <= 1);

  @override
  State<BookReadingProgressBar> createState() => _BookReadingProgressBarState();
}

class _BookReadingProgressBarState extends State<BookReadingProgressBar> {
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = widget.progress; // Initialize with the passed progress value
  }

  @override
  void didUpdateWidget(covariant BookReadingProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      setState(() {
        progress = widget.progress; // Update progress if it changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF3A3939),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: widget.child,
          ),
          Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Colors.grey[300],
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: progress == 1.0
                        ? const Radius.circular(10.0)
                        : Radius.zero,
                  ),
                  color: const Color(0xFF91D786),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
