import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerSimple extends StatefulWidget {
  const BarcodeScannerSimple({super.key});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  Barcode? _barcode;
  bool _isBarcodeDetected = false; // Flag to track if barcode is detected

  // Return the barcode when it is detected
  void _handleBarcode(BarcodeCapture barcodes) {
    if (_isBarcodeDetected || !mounted) {
      return; // Exit if barcode already detected or widget is unmounted
    }

    _barcode = barcodes.barcodes.firstOrNull;
    if (_barcode != null) {
      _isBarcodeDetected = true; // Mark as detected to prevent multiple pops
      Navigator.pop(context, _barcode!.displayValue); // Pop only once
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Simple scanner',
          style: TextStyle(color: MyColors.titleColor),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        _barcode?.displayValue ?? 'Scan something!',
                        overflow: TextOverflow.fade,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
