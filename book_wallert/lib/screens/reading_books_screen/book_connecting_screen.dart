import 'package:book_wallert/controllers/add_reading_books_controller.dart';
import 'package:book_wallert/screens/barcode_scanner_screen/barcode_scanning_screen.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class BookConnectingScreen extends StatefulWidget {
  const BookConnectingScreen({super.key});

  @override
  State<BookConnectingScreen> createState() => _BookConnectingScreenState();
}

class _BookConnectingScreenState extends State<BookConnectingScreen> {
  final AddReadingBooksController _addReadingBooksController =
      AddReadingBooksController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _textSearched = false;
  int? _selectedIndex;

  void _nameSearch() async {
    await _addReadingBooksController.fetchBooks(context,
        page: 1, query: _searchController.text);
    setState(() {});
  }

  void _updateResults(int index) {
    if (_addReadingBooksController.books.isNotEmpty) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _scanBarcode() async {
    var isbn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerSimple(),
      ),
    );
    if (isbn is String && isbn.isNotEmpty) {
      String searchText = 'isbn:$isbn';
      await _addReadingBooksController.fetchBooks(context,
          page: 1, query: searchText);

      setState(() {});
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
          'Connect a Book',
          style: TextStyle(
            color: MyColors.titleColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.nonSelectedItemColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: MyColors.bgColor),
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: MyColors.bgColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
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
            const SizedBox(height: 20),
            if (_textSearched)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _addReadingBooksController.books.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _addReadingBooksController.books.length) {
                      return ListTile(
                        title: Text(_addReadingBooksController.books[index].title),
                        onTap: () {
                          _updateResults(index);
                        },
                      );
                    } else {
                      return buildProgressIndicator();
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
