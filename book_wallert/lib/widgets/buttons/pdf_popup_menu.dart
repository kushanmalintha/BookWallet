import 'package:flutter/material.dart';

class PDFPopupMenu extends StatelessWidget {
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onVisibility;
  final bool progressVisiblity;

  const PDFPopupMenu({
    super.key,
    required this.onRename,
    required this.onDelete,
    required this.onVisibility,
    required this.progressVisiblity,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      // elevation: 20,
      // shadowColor: Colors.black,
      iconColor: const Color(0xFFF3EFEF),
      onSelected: (value) {
        if (value == 0) {
          onRename();
        } else if (value == 1) {
          onDelete();
        } else if (value == 2) {
          onVisibility();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Rename'),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Delete'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: progressVisiblity
              ? Text('Hide Progrress Bar')
              : Text('Add Progrress Bar'),
        ),
      ],
      icon: const Icon(
        Icons.more_vert,
      ),
    );
  }
}
