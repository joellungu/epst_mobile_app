import 'dart:async';
import 'dart:typed_data';
import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class LeconPdf extends StatelessWidget {
  //
  Requete requete = Requete();
  //
  String type;
  //
  String cours;
  //
  String categorie;
  //
  String banche;
  //
  String notion;
  //
  int classe;
  //
  String typeFormation;
  //
  var box = GetStorage();
  //
  bool connec;
  //
  LeconPdf(this.cours, this.categorie, this.banche, this.type, this.notion,
      this.classe, this.connec, this.typeFormation,
      {Key? key})
      : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      //cours/checkcours
      body: connec
          ? FutureBuilder(
              future: checkCours(cours, categorie, banche, type, notion, classe,
                  typeFormation),
              builder: (c, t) {
                if (t.hasData) {
                  //
                  String id = t.data as String;

                  if (id != "0") {
                    //
                    // final pdfController = PdfController(
                    //   document: PdfDocument.openData(getData(id)),
                    // );
                    //
                    //pdfController
                    //  .openDocument(PdfDocument.openAsset('assets/sample.pdf'));
                    //https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(banche),
                        actions: [
                          PopupMenuButton(
                            onSelected: (e) async {
                              //
                              if (e == 1) {
                                //
                                Get.dialog(
                                  Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                                //
                                String nomFichier =
                                    "$cours-$categorie-$banche-$type-$notion-$classe-$typeFormation";
                                //
                                Uint8List fichier = await getData(id);
                                box.write(nomFichier, fichier);
                              }
                              if (e == 2) {
                                //
                              }
                            },
                            itemBuilder: (c) {
                              return const [
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.file_download_done),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("Télécharger le cours")
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.question_mark),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("A propos"),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          )
                        ],
                        centerTitle: true,
                      ),
                      body: SfPdfViewer.network(
                          '${Connexion.lien}cours/coursDataPdf.pdf?id=$id'),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(banche),
                        centerTitle: true,
                      ),
                      body: Container(),
                    );
                  }
                } else if (t.hasError) {
                  //
                  return Container();
                }
                return const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          : FutureBuilder(
              future:
                  readData("$cours-$categorie-$banche-$type-$notion-$classe"),
              builder: (c, t) {
                if (t.hasData) {
                  Map d = t.data as Map;
                  if (d['vide'] == "vide") {
                    return Container();
                  } else {
                    //Lire en locale...
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(banche),
                        centerTitle: true,
                      ),
                      body: SfPdfViewer.memory(d['lire']),
                    );
                  }
                } else if (t.hasError) {
                  return Container();
                }
                return Container();
              },
            ),
    );
  }

//package:get/get_connect/http/src/response/response.dart
  //
  Future<String> checkCours(String cours, String categorie, String banche,
      String type, String notion, int classe, String propriete) async {
    //
    categorie = categorie.toLowerCase();
    cours = cours.toLowerCase();
    //
    Response response = await requete.getE(
        "cours/checkcours?cours=$cours&categorie=$categorie&banche=$banche&type=$type&notion=$notion&classe=$classe&propriete=$propriete");
    //
    if (response.isOk) {
      //
      print("statusCode: ${response.statusCode}");
      print("body: ${response.body}");
      return response.bodyString!;
    } else {
      //
      print("statusCode: ${response.statusCode}");
      print("body: ${response.body}");
      return "0";
    }
  }

  //
  Future<Map<String, Object>> readData(String id) async {
    //
    Uint8List data = box.read(id);
    //await requete.getE("cours/coursDataPdf.pdf?id=$id");
    //
    if (data.isNotEmpty) {
      //print("livre téléchargé ok: ${response.statusCode}");
      //
      return {"lire": data};
    } else {
      //
      print("livre téléchargé erreur: $data");
      return {"vide": "vide"};
    }
  }

  //
  Future<Uint8List> getData(String id) async {
    //
    http.Response response = await http
        .get(Uri.parse("${Connexion.lien}cours/coursDataPdf.pdf?id=$id"));
    //
    print('response.isOk ${response.statusCode}');
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("livre téléchargé ok: ${response.statusCode}");
      //
      Get.back();
      Get.snackbar("Succès", "Enregistrement éffectué");
      return response.bodyBytes;
    } else {
      //
      Get.back();
      Get.snackbar(
        "Erreur",
        "Enregistrement non éffectué",
        backgroundColor: Colors.red.shade900,
      );
      print("livre téléchargé erreur: ${response.body}");
      return Uint8List(0);
    }
  }
}
