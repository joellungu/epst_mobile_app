import 'package:epst_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'recherche_annee.dart';
import 'recherche_ecole.dart';

class Palmares extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Palmares();
  }
}

class _Palmares extends State<Palmares> {
  //
  int p = 0;
  int d = 0;
  //
  List listeProvince = [
    "Bas-Uele",
    "Équateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasai",
    "Kasai central",
    "Kasai oriental",
    "Kinshasa",
    "Kongo Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];
  //
  int ti = 0;
  int a = 1900;
  //
  List liste_annee = [];
  //
  WebViewController? controlleur;

  @override
  void initState() {
    //
    for (int i = 0; i < 500; i++) {
      liste_annee.add(a);
      a++;
    }
    //lien_siite
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande palmares"),
      ),
      body: false
          ? WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController w) {
                controlleur = w;
              },
              initialUrl:
                  "https://www.eduquepsp.education", //https://www.youtube.com
              //"https://www.efoad.minepst.gouv.cd",
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ecole",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: InkWell(
                      onTap: () {
                        //
                        showSearch(
                            context: context, delegate: RechercheEcole());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          //width: Get.size.width,
                          child: Obx(
                            () => Text(
                              ecole.value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ///////////
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Année-scolaire",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: InkWell(
                      onTap: () {
                        //
                        showSearch(
                            context: context, delegate: RechercheAnnee());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          //width: Get.size.width,
                          child: Obx(
                            () => Text(
                              annee.value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ///////////
                  const SizedBox(
                    height: 10,
                  ),

                  ///
                  ElevatedButton(
                    onPressed: () async {
                      //
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text("Envoyer"),
                    ),
                  ),
                ],
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controlleur!.reload();
      //   },
      //   child: Icon(Icons.sync),
      // ),
    );
  }
}
