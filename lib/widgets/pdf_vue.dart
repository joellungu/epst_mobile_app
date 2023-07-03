import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfVue extends StatelessWidget {
  String path;
  PdfVue(this.path) {
    //
    print("le path: $path");
    //
    pdfController = PdfController(
      document: PdfDocument.openFile(path),
    );
  }
  //
  //-- or --//

  var pdfController = PdfController(
    document: PdfDocument.openAsset('assets/sample.pdf'),
  );
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.indigo.shade900,
      ),
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
