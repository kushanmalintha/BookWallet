import 'dart:convert';
import 'dart:io';
import 'package:book_wallert/controllers/add_reading_books_controller.dart';
import 'package:book_wallert/screens/reading_books_screen/pdf_reader/pdf_data_model.dart';
import 'package:book_wallert/screens/barcode_scanner_screen/barcode_scanning_screen.dart';
import 'package:book_wallert/services/fetch_bookId_from_isbn.dart';
import 'package:book_wallert/widgets/cards/book_cards/book_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddPhysicalBookScreen extends StatefulWidget {
  const AddPhysicalBookScreen({super.key});

  @override
  State<AddPhysicalBookScreen> createState() => _AddPhysicalBookScreenState();
}

class _AddPhysicalBookScreenState extends State<AddPhysicalBookScreen> {
  File? _image;
  final _titleController = TextEditingController();
  final _pagesController = TextEditingController();
  final AddReadingBooksController _addReadingBooksController =
      AddReadingBooksController();
  final TextEditingController _searchController = TextEditingController();
  final _bookIdService = BookIdService();
  final ScrollController _scrollController = ScrollController();
  bool _textSearched = false;

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

  void _addPhysicalBook() async {
    Map<String, Object> newBook;
    int? globalId;
    if (_titleController.text.isNotEmpty &&
        _pagesController.text.isNotEmpty &&
        _pagesController.text != "0" &&
        _image != null) {
      if (_addReadingBooksController.books.isNotEmpty) {
        // Checking if connectable to a book
        globalId = await _bookIdService.fetchId(_addReadingBooksController
            .books[0]); // Updating global book id (from our database)
      }
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
        'data': PDFData(id: newId, globalId: globalId)
            .toJson(), // Store additional data if needed
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
    _textSearched = false;
    // _booksController.books = <BookModel>[];

    var isbn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerSimple(),
      ),
    );
    if (isbn is String && isbn.isNotEmpty) {
      String searchText = '';
      searchText = 'isbn:$isbn';
      await _addReadingBooksController.fetchBooks(context,
          page: 1, query: searchText);

      // Updating the book details
      if (_addReadingBooksController.books.isNotEmpty) {
        setState(() {
          _titleController.text = _addReadingBooksController.books[0].title;
          _pagesController.text =
              _addReadingBooksController.books[0].pages.toString();
          _fetchAndSaveImage(_addReadingBooksController.books[0].imageUrl);
        });
      }
    }
  }

  void _nameSearch() async {
    _titleController.clear();
    _pagesController.clear();
    await _addReadingBooksController.fetchBooks(context,
        page: 1, query: _searchController.text);
    setState(() {});
  }

  void _updateResults(int index) {
    if (_addReadingBooksController.books.isNotEmpty) {
      setState(() {
        _titleController.text = _addReadingBooksController.books[index].title;
        _pagesController.text =
            _addReadingBooksController.books[index].pages.toString();
        _fetchAndSaveImage(_addReadingBooksController.books[index].imageUrl);
      });
    }
  }

  Future<void> _fetchAndSaveImage(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Get the application directory of the device
        final directory = await getApplicationDocumentsDirectory();

        // Create a unique file path in the temporary directory
        final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
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
        elevation: 0,
        backgroundColor: MyColors.navigationBarColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Physical Book',
          style: TextStyle(
            color: MyColors.titleColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(color: MyColors.textColor),
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Book Title',
                      hintStyle:
                          TextStyle(color: MyColors.nonSelectedItemColor),
                    ),
                  ),
                  TextField(
                    style: const TextStyle(color: MyColors.textColor),
                    controller: _pagesController,
                    decoration: const InputDecoration(
                      labelText: 'Total Pages',
                      hintStyle:
                          TextStyle(color: MyColors.nonSelectedItemColor),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _image == null
                      ? const Text(
                          'No image selected.',
                          style:
                              TextStyle(color: MyColors.nonSelectedItemColor),
                        )
                      : Image.file(_image!, height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Select Image'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _captureImage,
                        child: const Text('Take Image'),
                      ),
                    ],
                  ),
                  const SpaceBrakerLine(),
                  GestureDetector(
                    onTap: _scanBarcode,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scan Barcode",
                          style: TextStyle(color: MyColors.text2Color),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.qr_code_scanner,
                          color: MyColors.nonSelectedItemColor,
                        ),
                      ],
                    ),
                  ),
                  const SpaceBrakerLine(),
                  // Search Input Field
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textSearched = true;
                      });
                      _nameSearch();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColors
                                  .nonSelectedItemColor, // Set background color
                              borderRadius: BorderRadius.circular(
                                  8), // Optional: for rounded corners
                            ),
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: MyColors.bgColor),
                              decoration: const InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color:
                                      MyColors.bgColor, // Set hint text color
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12), // Padding
                              ),
                              onSubmitted: (query) {
                                setState(() {
                                  _textSearched = true;
                                  _nameSearch();
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.search,
                          color: MyColors.nonSelectedItemColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // ListView for displaying search results
                  if (_textSearched)
                    Container(
                      height: 450, // Set a fixed height for the list view
                      child: ListView.builder(
                        controller:
                            _scrollController, // Attach scroll controller
                        itemCount: _addReadingBooksController.books.length +
                            1, // Number of items in the list
                        itemBuilder: (context, index) {
                          if (index < _addReadingBooksController.books.length) {
                            return Column(
                              children: [
                                const SizedBox(
                                    height: 3), // Spacer between cards
                                Stack(
                                  children: [
                                    BookCard(
                                      book: _addReadingBooksController
                                          .books[index],
                                    ),
                                    // Adding the GestureDetector for a transparent layer
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle the tap event here
                                          print(
                                              "Book tapped: ${_addReadingBooksController.books[index].title}");
                                          _updateResults(index);
                                          // You can also navigate or show more information about the book here
                                        },
                                        child: Container(
                                          color: Colors
                                              .transparent, // Transparent overlay to detect taps
                                        ),
                                      ),
                                    ),
                                  ],
                                ), // Display book card
                              ],
                            );
                          } else {
                            return buildProgressIndicator(); // Show loading indicator at the end
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addPhysicalBook,
                child: const Text('Add Book'),
              ),
            ),
          ),
        ],
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

class SpaceBrakerLine extends StatelessWidget {
  const SpaceBrakerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      // Line Seperator with OR
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(thickness: 1, color: MyColors.nonSelectedItemColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "or",
            style: TextStyle(color: MyColors.nonSelectedItemColor),
          ),
        ),
        Expanded(
            child: Divider(thickness: 1, color: MyColors.nonSelectedItemColor)),
      ],
    );
  }
}
