import 'dart:ui';

import 'package:pdf_render/pdf_render.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String?> getFirstPageImage(String pdfPath) async {
  try {
    final doc = await PdfDocument.openFile(pdfPath);
    var page = await doc.getPage(1);
    var imgPDF = await page.render();
    var img = await imgPDF.createImageDetached();
    var imgBytes = await img.toByteData(format: ImageByteFormat.png);
    var libImage = imglib.decodeImage(imgBytes!.buffer
        .asUint8List(imgBytes.offsetInBytes, imgBytes.lengthInBytes));

    // Save image as a file
    final directory = await getApplicationDocumentsDirectory();
    final imgFile = File('${directory.path}/${pdfPath.hashCode}.jpg');
    await imgFile.writeAsBytes(imglib.encodeJpg(libImage!));
    return imgFile.path;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

