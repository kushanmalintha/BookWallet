import 'package:book_wallert/screens/barcode_scanner_screen/barcode_scanning_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Assuming BarcodeScannerSimple is in this package or similar import

class Screen7 extends StatefulWidget {
  const Screen7({super.key});

  @override
  _Screen7State createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {
  String? scannedISBN;

  Future<void> scanISBN() async {
    // Trigger the barcode scanner and wait for the result
    final isbn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerSimple(),
      ),
    );

    // If an ISBN was scanned, update the state to show it
    if (isbn != null) {
      setState(() {
        scannedISBN = isbn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan ISBN')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scanISBN,
              child: const Text('Scan ISBN'),
            ),
            const SizedBox(height: 20),
            if (scannedISBN != null)
              Text(
                'Scanned ISBN: $scannedISBN',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
