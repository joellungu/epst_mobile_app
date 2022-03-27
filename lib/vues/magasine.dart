import 'dart:async';
import 'dart:convert';
import 'package:epst_app/utils/connexion.dart';
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
  //
  Future<Widget> loadMagasin() async {
    List<Map<String, dynamic>> liste = await Connexion.liste_magasin(1);
    print("longueur  ___  $liste");
    return ListView(
      children: List.generate(liste.length, (index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PdfVue(
                  titre: liste[index]["libelle"],
                  id: liste[index]["id"],
                ),
              ),
            );
          },
          leading: Icon(
            Icons.file_copy,
            color: Colors.black,
          ),
          title: Text(liste[index]["libelle"]),
          subtitle: Text(liste[index]["date"]),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
        );
      }),
    );
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: loadMagasin(),
        builder: (context, t) {
          if (t.hasData) {
            return t.data as Widget;
          } else if (t.hasError) {
            return Center(
              child: Text("Problème de connexion"),
            );
          }
          return Center(
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class PdfVue extends StatefulWidget {
  String? titre;
  int? id;

  PdfVue({this.titre, this.id});

  @override
  State<StatefulWidget> createState() {
    return _PdfVue();
  }
}

class _PdfVue extends State<PdfVue> {
  PdfDocumentLoadedDetails? pdfFile;
  int a = 1;
  PdfViewerController? _pdfViewerController;

  Future<Widget> loadVue() async {
    Map<String, dynamic> mag = await Connexion.getMagasin(widget.id!);
    print(mag["date"]);
    print(mag["id"]);
    print(mag["description"]);
    print(mag["libelle"]);
    //print(mag["piecejointe"]);

    return SfPdfViewer.memory(
      base64Decode(mag["piecejointe"]),
      controller: _pdfViewerController,
      onDocumentLoaded: (pdf) {
        pdfFile = pdf;
      },
    );

    /*
    return Center(
      child: Text("cool"),
    );
    */
  }

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
      body: FutureBuilder(
        future: loadVue(),
        builder: (context, t) {
          if (t.hasData) {
            return t.data as Widget;
          } else if (t.hasError) {
            return Center(
              child: Text("Problème de connexion"),
            );
          }
          return Center(
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Aller à la page"),
                content: Container(
                  height: 100,
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<int>(
                          value: a,
                          onChanged: (value) {
                            a = value as int;
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
                          print("le numero de la page: $a");
                          Timer(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Center(
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
