import 'dart:io';
import 'package:book_wallert/screens/main_screen/pdf_reader/book_viewer_page.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_view_page.dart';
import 'package:book_wallert/widgets/buttons/pdf_popup_menu.dart';
import 'package:flutter/material.dart';

class PDFCard extends StatelessWidget {
  final String? type;
  final String name;
  final String path;
  final String imagePath;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onVisibility;
  final bool progressVisiblity;
  final VoidCallback onRefresh;

  const PDFCard({
    super.key,
    this.type,
    required this.name,
    required this.path,
    required this.imagePath,
    required this.onRename,
    required this.onDelete,
    required this.onVisibility,
    required this.progressVisiblity,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (type == null || type == "pdf") {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewerPage(filePath: path, title: name),
            ),
          ).then((_) {
            onRefresh();
          });
        } else if (type == "physical") {
          print("Openning non-pdf-screen");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookViewerPage(filePath: path, title: name),
            ),
          ).then((_) {
            onRefresh();
          });
        }
        ;
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
              child: PDFPopupMenu(
                onRename: onRename,
                onDelete: onDelete,
                onVisibility: onVisibility,
                progressVisiblity: progressVisiblity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
