import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/book_mark_manager.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_data_model.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookViewerPage extends StatefulWidget {
  final String filePath;
  final String title;

  const BookViewerPage(
      {super.key, required this.filePath, required this.title});

  @override
  State<BookViewerPage> createState() => _BookViewerPageState();
}

class _BookViewerPageState extends State<BookViewerPage> {
  int currentPage = 1;
  int totalPages = 1;
  bool showPageNumber = false;
  Timer? _timer;
  double sliderValue = 0;

  final List<Map<String, String>> _bookmarks = [];
  PDFData? pdfData;

  Future<void> _loadPDFData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/pdf_files.json');
    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        final List<dynamic> json = jsonDecode(contents);
        final pdfFile = json.firstWhere(
          (element) => element['path'] == widget.filePath,
          orElse: () => {},
        );
        if (pdfFile.isNotEmpty) {
          setState(() {
            pdfData = PDFData.fromJson(pdfFile['data']);
            currentPage = pdfData!.currentPage;
            totalPages = pdfFile['totalPages'];
            _bookmarks.addAll(pdfData!.bookmarks);
            sliderValue = pdfData!.progress * 100;
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error loading PDF data: $e");
        }
      }
    }
  }

  Future<void> _savePDFData() async {
    if (pdfData != null) {
      pdfData!.bookmarks = _bookmarks;
      pdfData!.currentPage = currentPage;
      pdfData!.progress = currentPage / totalPages;

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/pdf_files.json');
      final contents = await file.readAsString();
      final List<dynamic> json = jsonDecode(contents);
      final updatedJson = json.map((pdfFile) {
        if (pdfFile['path'] == widget.filePath) {
          pdfFile['data'] = pdfData!.toJson();
        }
        return pdfFile;
      }).toList();
      await file.writeAsString(jsonEncode(updatedJson));
    }
  }

  Future<void> _onWillPop() async {
    _savePDFData();
  }

  @override
  void initState() {
    super.initState();
    _loadPDFData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showPageNumber(int page) {
    setState(() {
      currentPage = page;
      showPageNumber = true;
    });

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        showPageNumber = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        _onWillPop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF282A24),
        appBar: AppBar(
          backgroundColor: const Color(0xFF282A24),
          automaticallyImplyLeading: false,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFB4BCB3),
            ),
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_add, color: Color(0xFFB4BCB3)),
              onPressed: () {
                BookmarkManager.addBookmark(
                    context, currentPage, _bookmarks, setState);
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Color(0xFFB4BCB3)),
              onPressed: () {
                BookmarkManager.showBookmarks(context, currentPage, (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                }, _bookmarks, setState);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Page: ${currentPage + 1}',
                    style: TextStyle(color: MyColors.text2Color),
                  ),
                  Text(
                    'Total Pages: ${totalPages + 1}',
                    style: TextStyle(color: MyColors.text2Color),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorColor: MyColors.selectedItemColor,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: MyColors.titleColor),
                decoration: const InputDecoration(
                    focusColor: MyColors.text2Color,
                    labelText: 'Enter page number',
                    fillColor: MyColors.textColor),
                onSubmitted: (value) {
                  final int page = int.tryParse(value) ?? currentPage;
                  if (page > 0 && page <= totalPages) {
                    setState(() {
                      currentPage = page - 1;
                      _showPageNumber(currentPage);
                    });
                  }
                },
              ),
            ),
            PDFSlider(
              sliderValue: currentPage / totalPages * 100,
              onChanged: (value) async {
                setState(() {
                  sliderValue = value;
                  if (totalPages > 0) {
                    currentPage = ((value / 100) * totalPages).round();
                    // pdfController.setPage(targetPage);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
