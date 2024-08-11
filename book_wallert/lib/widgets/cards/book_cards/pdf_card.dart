import 'dart:io';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_view_page.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';

class PDFCard extends StatelessWidget {
  final String name;
  final String path;
  final String imagePath;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onVisibility;
  final VoidCallback onRefresh;

  const PDFCard({
    super.key,
    required this.name,
    required this.path,
    required this.imagePath,
    required this.onRename,
    required this.onDelete,
    required this.onVisibility,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(filePath: path, title: name),
            fullscreenDialog: true, // This makes the new page fullscreen
          ),
        ).then((_) {
          onRefresh();
        });
      },
      child: AspectRatio(
        aspectRatio: 0.75, // Adjust the aspect ratio as needed
        child: Stack(
          children: [
            Card(
              elevation: 0,
              color: const Color(0xFF3A3939),
              margin: const EdgeInsets.all(4),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double imageHeight = constraints.maxWidth * 0.80;
                        return SizedBox(
                          height:
                              imageHeight, // Adjust height based on card width
                          child: imagePath.isNotEmpty
                              ? Image.file(File(imagePath),
                                  fit: BoxFit.scaleDown)
                              : const Icon(Icons.picture_as_pdf,
                                  size: 50, color: Colors.red),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 30,
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFFF3EFEF)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: CustomPopupMenuButtons(
                items: const [
                  'Rename',
                  'Delete',
                  'Progress Bar',
                ],
                onItemTap: [
                  onRename,
                  onDelete,
                  onVisibility,
                ],
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: MyColors.text2Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
