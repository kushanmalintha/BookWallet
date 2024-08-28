import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_data_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddPhysicalBookScreen extends StatefulWidget {
  @override
  _AddPhysicalBookScreenState createState() => _AddPhysicalBookScreenState();
}

class _AddPhysicalBookScreenState extends State<AddPhysicalBookScreen> {
  File? _image;
  final _titleController = TextEditingController();
  final _pagesController = TextEditingController();

  List<Map<String, dynamic>> pdfFiles =
      []; // To hold the list of PDF and physical books

  @override
  void initState() {
    super.initState();
    loadPdfFiles(); // Load existing PDF and physical book data
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _captureImage() async {
    final capturedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        _image = File(capturedFile.path);
      });
    }
  }

  // Load saved PDF and physical book information from the local storage
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
        print("Error loading files: $e");
      }
    }
  }

  // Save the current list of PDF files and physical books to local storage
  Future<void> savePdfFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/pdf_files.json');

    final newContents = jsonEncode(pdfFiles);
    await file.writeAsString(newContents);
  }

  void _addPhysicalBook() {
    var newBook = null;
    if (_titleController.text.isNotEmpty &&
        _pagesController.text.isNotEmpty &&
        _image != null) {
      final String newId =
          DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID
      newBook = {
        'id': newId,
        'progressVisiblity': false,
        'name': _titleController.text,
        'type': 'physical', // Differentiating type as 'physical'
        'path': _image!
            .path, // Using the image path as a placeholder for the book cover
        'image': _image!.path,
        'data': PDFData(id: newId).toJson(), // Store additional data if needed
        'totalPages': int.parse(_pagesController.text),
      };

      setState(() {
        pdfFiles.add(newBook); // Add the new physical book to the list
        savePdfFiles(); // Save updated list
      });

      Navigator.pop(context, newBook); // Pass the new book back if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Physical Book'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
            TextField(
              controller: _pagesController,
              decoration: InputDecoration(labelText: 'Total Pages'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 150),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: Text('Take Image'),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _addPhysicalBook,
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
