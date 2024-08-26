import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/screens/main_screen/pdf_reader/book_mark_manager.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'full_screen_toggle.dart';
import 'pdf_slider.dart';

class PDFViewerPage extends StatefulWidget {
  final String filePath;
  final String title;

  const PDFViewerPage({super.key, required this.filePath, required this.title});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  bool isVertical = true;
  bool isFullScreen = false;
  bool isScrollVisible = false;
  bool showSettings = false;
  bool pageSnap = true;
  bool autoSpacing = true;
  bool pageFling = true;
  bool nightMode = false;
  late PDFViewController pdfController;
  double sliderValue = 0;
  int totalPages = 0;
  bool errorOccurred = false;
  int currentPage = 0;
  int initialPage = 0;
  bool showPageNumber = false;
  Timer? _timer;

  final List<Map<String, String>> _bookmarks = [];

  PDFData? pdfData;

  void _addBookmark() =>
      BookmarkManager.addBookmark(context, currentPage, _bookmarks, setState);

  void _showBookmarks() => BookmarkManager.showBookmarks(
      context, currentPage, pdfController.setPage, _bookmarks, setState);

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
            initialPage = pdfData!.currentPage;
            currentPage = pdfData!.currentPage;
            _bookmarks.addAll(pdfData!.bookmarks);
            isVertical = pdfData!.isVertical;
            pageSnap = pdfData!.pageSnap;
            autoSpacing = pdfData!.autoSpacing;
            pageFling = pdfData!.pageFling;
            nightMode = pdfData!.nightMode;
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
      pdfData!.isVertical = isVertical;
      pdfData!.pageSnap = pageSnap;
      pdfData!.autoSpacing = autoSpacing;
      pdfData!.pageFling = pageFling;
      pdfData!.nightMode = nightMode;
      pdfData!.currentPage = currentPage;
      pdfData!.progress = currentPage / totalPages;

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/pdf_files.json');
      final contents = await file.readAsString();
      final List<dynamic> json = jsonDecode(contents);
      final updatedJson = json.map((pdfFile) {
        if (pdfFile['path'] == widget.filePath) {
          pdfFile['data'] = pdfData!.toJson();
          pdfFile['totalPages'] = totalPages;
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

  void _updateViewSettings(bool Function() updateSetting) {
    final currentPageBackup = currentPage; // Store the current page
    setState(() {
      updateSetting();
    });
    pdfController.setPage(currentPageBackup); // Restore the current page
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
        appBar: isFullScreen
            ? null
            : AppBar(
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
                    icon: const Icon(Icons.bookmark_add,
                        color: Color(0xFFB4BCB3)),
                    onPressed: _addBookmark,
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Color(0xFFB4BCB3)),
                    onPressed: _showBookmarks,
                  ),
                  IconButton(
                    icon: Icon(Icons.linear_scale_rounded,
                        color: isScrollVisible
                            ? const Color(0xFFB4BCB3)
                            : const Color.fromARGB(144, 180, 188, 179)),
                    onPressed: () {
                      setState(() {
                        isScrollVisible = !isScrollVisible;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isVertical ? Icons.swap_horiz : Icons.swap_vert,
                      color: const Color(0xFFB4BCB3),
                    ),
                    onPressed: () async {
                      _updateViewSettings(() => isVertical = !isVertical);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Color(0xFFB4BCB3),
                    ),
                    onPressed: () {
                      setState(() {
                        isFullScreen = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu_rounded,
                        color: Color(0xFFB4BCB3)),
                    onPressed: () {
                      setState(() {
                        showSettings = !showSettings;
                      });
                    },
                  ),
                ],
              ),
        body: errorOccurred
            ? const Center(
                child: Text(
                'Error loading PDF',
              ))
            : Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: PDFView(
                                key: Key(
                                    '$pageSnap-$autoSpacing-$pageFling-$isVertical-$nightMode-$initialPage'),
                                pageSnap: pageSnap,
                                autoSpacing: autoSpacing,
                                pageFling: pageFling,
                                defaultPage: currentPage,
                                nightMode: nightMode,
                                filePath: widget.filePath,
                                swipeHorizontal: !isVertical,
                                onViewCreated: (PDFViewController controller) {
                                  pdfController = controller;
                                  controller.getPageCount().then((count) {
                                    setState(() {
                                      totalPages = count!;
                                    });
                                  });
                                  controller.setPage(currentPage);
                                },
                                onRender: (pages) {
                                  setState(() {
                                    totalPages = pages!;
                                    errorOccurred = false;
                                  });
                                },
                                onError: (error) {
                                  setState(() {
                                    errorOccurred = true;
                                  });
                                  if (kDebugMode) {
                                    print(error.toString());
                                  }
                                },
                                onPageError: (page, error) {
                                  setState(() {
                                    errorOccurred = true;
                                  });
                                  if (kDebugMode) {
                                    print('$page: ${error.toString()}');
                                  }
                                },
                                onPageChanged: (int? currentPage, int? total) {
                                  if (totalPages > 0 && currentPage != null) {
                                    setState(() {
                                      this.currentPage = currentPage;
                                      sliderValue =
                                          (currentPage / totalPages) * 100;
                                    });
                                    _showPageNumber(currentPage);
                                  }
                                },
                              ),
                            ),
                            if (!isVertical && !isFullScreen && isScrollVisible)
                              Column(
                                children: [
                                  PDFSlider(
                                    sliderValue: sliderValue,
                                    onChanged: (value) async {
                                      setState(() {
                                        sliderValue = value;
                                      });
                                      if (totalPages > 0) {
                                        int targetPage =
                                            ((value / 100) * totalPages)
                                                .round();
                                        pdfController.setPage(targetPage);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (isVertical && !isFullScreen && isScrollVisible)
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: PDFSlider(
                                sliderValue: sliderValue,
                                onChanged: (value) async {
                                  setState(() {
                                    sliderValue = value;
                                  });
                                  if (totalPages > 0) {
                                    int targetPage =
                                        ((value / 100) * totalPages).round();
                                    pdfController.setPage(targetPage);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (showSettings && !isFullScreen)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 250,
                        color: Colors.white,
                        child: ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: [
                            ListTile(
                              leading: const Icon(Icons.pages),
                              title: const Text("Page Snap"),
                              trailing: Switch(
                                value: pageSnap,
                                onChanged: (value) async {
                                  setState(() {
                                    pageSnap = value;
                                    _savePDFData();
                                  });
                                  await pdfController.setPage(currentPage);
                                },
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.space_bar),
                              title: const Text("Auto Spacing"),
                              trailing: Switch(
                                value: autoSpacing,
                                onChanged: (value) async {
                                  setState(() {
                                    autoSpacing = value;
                                    _savePDFData();
                                  });
                                  await pdfController.setPage(currentPage);
                                },
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.swap_vert),
                              title: const Text("Page Fling"),
                              trailing: Switch(
                                value: pageFling,
                                onChanged: (value) async {
                                  setState(() {
                                    pageFling = value;
                                    _savePDFData();
                                  });
                                  await pdfController.setPage(currentPage);
                                },
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.brightness_6),
                              title: const Text("Night Mode"),
                              trailing: Switch(
                                value: nightMode,
                                onChanged: (value) async {
                                  setState(() {
                                    nightMode = value;
                                    _savePDFData();
                                  });
                                  await pdfController.setPage(currentPage);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isFullScreen)
                    FullScreenToggle(
                      onPressed: () {
                        setState(() {
                          isFullScreen = false;
                        });
                      },
                      isFullScreen: isFullScreen,
                    ),
                  if (showPageNumber)
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 100.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Page: ${currentPage + 1}/$totalPages',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
