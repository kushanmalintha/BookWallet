import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BookmarkManager {
  static void addBookmark(
    BuildContext context,
    int currentPage,
    List<Map<String, String>> bookmarks,
    StateSetter setState,
  ) {
    final TextEditingController bookmarkNameController =
        TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Bookmark'),
          content: TextField(
            controller: bookmarkNameController,
            decoration: const InputDecoration(hintText: 'Enter bookmark name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  bookmarks.add({
                    'page': currentPage.toString(),
                    'name': bookmarkNameController.text.isEmpty
                        ? 'Bookmark ${bookmarks.length + 1}'
                        : bookmarkNameController.text
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  static void editBookmark(BuildContext context, int index,
      List<Map<String, String>> bookmarks, StateSetter setState) {
    final TextEditingController bookmarkNameController = TextEditingController(
      text: bookmarks[index]['name'],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Bookmark'),
          content: TextField(
            controller: bookmarkNameController,
            decoration: const InputDecoration(hintText: 'Enter new name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  bookmarks[index]['name'] = bookmarkNameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  static void removeBookmark(
      int index, List<Map<String, String>> bookmarks, StateSetter setState) {
    setState(() {
      bookmarks.removeAt(index);
    });
  }

  static void showBookmarks(
    BuildContext context,
    int currentPage,
    PDFViewController pdfController,
    List<Map<String, String>> bookmarks,
    StateSetter setState,
  ) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF282A24),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                return ListTile(
                  title: Text(
                    bookmark['name']!,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Page ${bookmark['page']}',
                    style: TextStyle(color: Colors.white30),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pdfController.setPage(int.parse(bookmark['page']!));
                    setState(() {
                      currentPage = int.parse(bookmark['page']!);
                    });
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white30,
                    ),
                    onPressed: () {
                      editBookmark(context, index, bookmarks, setState);
                    },
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white30,
                    ),
                    onPressed: () {
                      setState(() {
                        removeBookmark(index, bookmarks, setState);
                      });
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
