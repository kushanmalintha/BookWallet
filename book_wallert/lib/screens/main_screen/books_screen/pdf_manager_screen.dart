import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/functions/pdf_utils.dart';
import 'package:book_wallert/screens/main_screen/books_screen/add_book_screen.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_data_model.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:book_wallert/widgets/cards/book_cards/pdf_card.dart';
import 'package:book_wallert/widgets/frames/book_reading_progress_bar.dart';
import 'package:book_wallert/widgets/rename_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PDFManagerScreen extends StatefulWidget {
  const PDFManagerScreen({super.key});

  @override
  State<PDFManagerScreen> createState() => _PDFManagerScreenState();
}

class _PDFManagerScreenState extends State<PDFManagerScreen> {
  List<Map<String, dynamic>> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    // Load the list of PDF files when the screen is initialized
    loadPdfFiles();
  }

  // Load saved PDF file information from the local storage
  Future<void> loadPdfFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/pdf_files.json');

    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        final List<dynamic> json = jsonDecode(contents);
        setState(() {
          pdfFiles = json.map((e) => Map<String, dynamic>.from(e)).toList();
        });
      } catch (e) {
        if (kDebugMode) {
          print("Error loading PDF files: $e");
        }
      }
    }
  }

  // Save the current list of PDF files to local storage
  Future<void> savePdfFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/pdf_files.json');

    List<Map<String, dynamic>> existingPdfFiles = [];

    // Load existing data from the file if it exists
    if (await file.exists()) {
      final existingContents = await file.readAsString();
      final List<dynamic> existingJson = jsonDecode(existingContents);
      existingPdfFiles =
          existingJson.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    // Create a map for quick lookup of existing PDF data by ID
    final Map<String, Map<String, dynamic>> existingDataById = {
      for (var pdf in existingPdfFiles) pdf['id']: pdf
    };

    // Create a new list to hold the updated PDF data to be saved
    List<Map<String, dynamic>> updatedPdfFiles = [];

    for (var pdf in pdfFiles) {
      final String id = pdf['id'];

      // Update the 'data' field in pdfFiles with the most recent data from the saved file
      if (existingDataById.containsKey(id)) {
        pdf['data'] = existingDataById[id]!['data'];
      }

      // Add the updated PDF to the final list
      updatedPdfFiles.add(pdf);
    }

    // Save the final list of PDFs back to the file
    final newContents = jsonEncode(updatedPdfFiles);
    await file.writeAsString(newContents);
  }

  // Generate a unique ID for each PDF file (based on the current timestamp)
  String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Allow the user to pick a PDF file and add it to the list
  Future<void> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;
      final directory = await getApplicationDocumentsDirectory();
      final newFile = await File(filePath).copy('${directory.path}/$fileName');
      final imagePath = await getFirstPageImage(newFile.path);

      // Generate a unique ID for the new PDF file
      final newId = generateUniqueId();

      // Add the new PDF file to the list and save the updated list
      setState(() {
        pdfFiles.add({
          'id': newId,
          'progressVisiblity': false,
          'name': fileName,
          'type': "pdf",
          'path': newFile.path,
          'image': imagePath ?? 'assets/default_thumbnail.png',
          'data': PDFData(id: newId).toJson(),
        });
        savePdfFiles();
      });
    }
  }

  // Allow the user to rename a PDF file
  Future<void> renamePdfFile(int index) async {
    String? newName = await showRenameDialog(context, pdfFiles[index]['name']!);

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        pdfFiles[index]['name'] = newName;
        savePdfFiles();
      });
    }
  }

  // Delete a PDF file from the list
  void deletePdfFile(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: const Text('Are You Sure?'),
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
                  pdfFiles.removeAt(index);
                  savePdfFiles();
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Toggle the visibility of the progress bar for a PDF file
  Future<void> changeProgressVisibility(int index) async {
    setState(() {
      pdfFiles[index]['progressVisiblity'] =
          !pdfFiles[index]['progressVisiblity'];
      savePdfFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        actions: [
          CustomPopupMenuButtons(
            items: const ['Add PDF Book', 'Add Physical Book'],
            onItemTap: [
              () {
                pickPdfFile();
              },
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPhysicalBookScreen()),
                ).then((_) {
                  loadPdfFiles();
                  ();
                });
              },
            ],
            icon: const Icon(
              Icons.playlist_add_sharp,
              color: MyColors.nonSelectedItemColor,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.create_new_folder,
                color: MyColors.nonSelectedItemColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_rounded,
                color: MyColors.nonSelectedItemColor,
              )),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemCount: pdfFiles.length,
            itemBuilder: (context, index) {
              return pdfFiles[index]['progressVisiblity'] ?? false
                  ? BookReadingProgressBar(
                      progress: pdfFiles[index]['data']['progress'] ?? 0,
                      child: PDFCard(
                        type: pdfFiles[index]['type'],
                        name: pdfFiles[index]['name']!,
                        path: pdfFiles[index]['path']!,
                        imagePath: pdfFiles[index]['image']!,
                        onRename: () => renamePdfFile(index),
                        onDelete: () => deletePdfFile(index),
                        onVisibility: () => changeProgressVisibility(index),
                        progressVisiblity: pdfFiles[index]['progressVisiblity'],
                        onRefresh: loadPdfFiles,
                      ),
                    )
                  : PDFCard(
                      type: pdfFiles[index]['type'],
                      name: pdfFiles[index]['name']!,
                      path: pdfFiles[index]['path']!,
                      imagePath: pdfFiles[index]['image']!,
                      onRename: () => renamePdfFile(index),
                      onDelete: () => deletePdfFile(index),
                      onVisibility: () => changeProgressVisibility(index),
                      progressVisiblity: pdfFiles[index]['progressVisiblity'],
                      onRefresh: loadPdfFiles,
                    );
            },
          );
        },
      ),
    );
  }
}
