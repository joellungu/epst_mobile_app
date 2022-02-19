import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Magasine extends StatefulWidget {
  String? titre;

  Magasine({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Magasine();
  }
}

class _Magasine extends State<Magasine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: ListView(
        children: List.generate(100, (index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PdfVue(
                    titre: "DYG  duy UYd  DUQY uysd",
                  ),
                ),
              );
            },
            leading: Icon(
              Icons.file_copy,
              color: Colors.black,
            ),
            title: Text("DYG  duy UYd  DUQY uysd"),
            subtitle: Text(" Mag du: 12/12/2022"),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          );
        }),
      ),
    );
  }
}

class PdfVue extends StatefulWidget {
  String? titre;

  PdfVue({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _PdfVue();
  }
}

class _PdfVue extends State<PdfVue> {
  PdfDocumentLoadedDetails? pdfFile;
  int a = 1;
  PdfViewerController? _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.titre!),
      ), //LE MAGAZINE DE L'EPST 4  01.12.2021.pdf
      body: SfPdfViewer.asset(
        "assets/LE MAGAZINE DE L'EPST 4  01.12.2021.pdf",
        controller: _pdfViewerController,
        onDocumentLoaded: (pdf) {
          pdfFile = pdf;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  height: 100,
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<int>(
                          value: a,
                          onChanged: (value) {
                            value = a;
                          },
                          items: List.generate(pdfFile!.document.pages.count,
                              (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text("Page $index"),
                            );
                          }),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pdfViewerController!.jumpToPage(a);
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text("Afficher"),
                        ),
                      )
                    ],
                  ),
                ),
                //Text(pdfFile.document.pages.count),
              );
            },
          );
        },
        child: Icon(Icons.menu),
      ),
    );
  }
}
