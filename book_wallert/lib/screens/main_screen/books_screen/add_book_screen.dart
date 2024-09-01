import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/controllers/add_reading_books_controller.dart';
import 'package:book_wallert/screens/main_screen/pdf_reader/pdf_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart'; // Import the barcode scanner package

class AddPhysicalBookScreen extends StatefulWidget {
  @override
  _AddPhysicalBookScreenState createState() => _AddPhysicalBookScreenState();
}

class _AddPhysicalBookScreenState extends State<AddPhysicalBookScreen> {
  File? _image;
  final _titleController = TextEditingController();
  final _pagesController = TextEditingController();
  final AddReadingBooksController _addReadingBooksController =
      AddReadingBooksController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

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
    var newBook;
    if (_titleController.text.isNotEmpty &&
        _pagesController.text.isNotEmpty &&
        _pagesController.text != "0" &&
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
    } else if (_pagesController.text == "0") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please Enter the Page Count.'),
          ),
        );
      }
    } else if (_titleController.text.isNotEmpty &&
        _pagesController.text.isNotEmpty &&
        _image == null &&
        _pagesController.text != "0") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please Select an Image.'),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please Enter Book Details.'),
          ),
        );
      }
    }
  }

  Future<void> _scanBarcode() async {
    _titleController.clear();
    _pagesController.clear();
    // _booksController.books = <BookModel>[];

    var isbn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );
    if (isbn is String && isbn.isNotEmpty) {
      String searchText = '';
      searchText = 'isbn:$isbn';
      _searchController.text = searchText;
      await _addReadingBooksController.fetchBooks(context,
          page: 1, query: _searchController.text);
      _updateResults();
    }
  }

  void _nameSearch() async {
    _titleController.clear();
    _pagesController.clear();
    await _addReadingBooksController.fetchBooks(context,
        page: 1, query: _searchController.text);
    _updateResults();
  }

  void _updateResults() {
    if (_addReadingBooksController.books.isNotEmpty)
      setState(() {
        _titleController.text = _addReadingBooksController.books[0].title;
        _pagesController.text =
            _addReadingBooksController.books[0].pages.toString();
        _fetchAndSaveImage(_addReadingBooksController.books[0].imageUrl);
        _isSearching = false;
      });
  }

  Future<void> _fetchAndSaveImage(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Get the application directory of the device
        final directory = await getApplicationDocumentsDirectory();

        // Create a unique file path in the temporary directory
        final uniqueFileName =
            'temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final filePath = '${directory.path}/$uniqueFileName';

        // Write the image data to the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Update the _image variable with the newly saved file
        setState(() {
          _image = file;
        });
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error fetching and saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.bgColor,
        automaticallyImplyLeading: false,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: MyColors.titleColor),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: MyColors.nonSelectedItemColor),
                  border: InputBorder.none,
                ),
              )
            : Text(
                'Add Physical Book',
                style: const TextStyle(
                  color: MyColors.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          if (_isSearching) ...[
            IconButton(
              icon: const Icon(Icons.search),
              color: MyColors.nonSelectedItemColor,
              onPressed: _nameSearch,
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              color: MyColors.nonSelectedItemColor,
              onPressed: _scanBarcode, // Trigger the barcode scanner
            ),
          ],
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            color: MyColors.nonSelectedItemColor,
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: MyColors.textColor),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                hintStyle: TextStyle(color: MyColors.nonSelectedItemColor),
              ),
            ),
            TextField(
              style: const TextStyle(color: MyColors.textColor),
              controller: _pagesController,
              decoration: InputDecoration(
                labelText: 'Total Pages',
                hintStyle: TextStyle(color: MyColors.nonSelectedItemColor),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
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

  @override
  void dispose() {
    _titleController.dispose();
    _pagesController.dispose();
    super.dispose();
  }
}
