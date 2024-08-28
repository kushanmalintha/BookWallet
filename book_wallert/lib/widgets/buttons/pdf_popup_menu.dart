import 'package:book_wallert/colors.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
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
    return CustomPopupMenuButtons(
      items: [
        'Rename',
        'Delete',
        progressVisiblity ? 'Hide Progrress Bar' : 'Add Progrress Bar',
      ],
      onItemTap: [
        () {
          onRename();
        },
        () {
          onDelete();
        },
        () {
          onVisibility();
        },
      ],
      icon: const Icon(
        Icons.more_vert,
        color: MyColors.nonSelectedItemColor,
      ),
    );
  }
}
