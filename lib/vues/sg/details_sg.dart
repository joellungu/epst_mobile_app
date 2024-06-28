import 'dart:convert';
import 'dart:io';

import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DetailsSG extends StatelessWidget {
  Map e;
  DetailsSG(this.e, {Key? key}) : super(key: key);
  //
  RxInt ie = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("${e['sigle']}"),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Obx(
        () => ie.value == 0
            ? ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  // const Text(
                  //   "Direction de communication et ...",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "${e['denomition']}",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Card(
                    elevation: 1,
                    child: SizedBox(
                      //height: 150,
                      width: Get.size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("NOM DU RESPONSABLE"),
                            subtitle: Text("${e['responsable']}"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone_android),
                            title: Text("TELEPHONE"),
                            subtitle: Text("${e['telephone']}"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("EMAIL"),
                            subtitle: Text("${e['email']}"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ADRESSE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    """${e['adresse']}""",
                  ),
                ],
              )
            : ie.value == 1
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: List.generate(
                      e['departement'].length,
                      (index) {
                        //departements
                        Map d = e['departement'][index];
                        // String ds = "";
                        // //ds.codeUnits
                        // List<int> images = [];
                        // d["photo"].map<int>((element) {
                        //   //
                        //   var intValue = int.tryParse(element);
                        //   images.add(intValue!);
                        //   //
                        // });
                        //File image = File("${e['id']}");
                        //image.writeAsStringSync(d["photo"]);
                        return Card(
                          elevation: 0,
                          child: SizedBox(
                            //height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                d["photo"] != null
                                    ? Expanded(
                                        flex: 3,
                                        child: Image.network(
                                            "${Connexion.lien}secretariat/photo/${e["id"]}/$index")
                                        // .memory(
                                        //   Uint8List.fromList(
                                        //     json.decode(d["photo"]).cast<int>(),
                                        //   ),
                                        // ),
                                        )
                                    : Container(),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ListTile(
                                      title: Text(
                                        "${d["responsable"]}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text.rich(
                                        TextSpan(
                                          text: "Departement: ",
                                          children: [
                                            TextSpan(
                                              text: "${d["departement"]}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : ie.value == 2
                    ? ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ARRET",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("""${e['arretes']['text']}""")
                        ],
                      )
                    : ie.value == 3
                        ? ListView(
                            padding: const EdgeInsets.all(10),
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ATTRIBUT. & MISSION",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              HtmlWidget("""${e['attributionMission']}""")
                            ],
                          )
                        : ie.value == 4
                            ? ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "REALISATIONS",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("""${e['realisation']}""")
                                ],
                              )
                            : ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "HISTORIQUES",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  HtmlWidget("""${e['historique']}"""),
                                ],
                              ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (e) {
            //
            ie.value = e;
            //
          },
          currentIndex: ie.value,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey.shade700,
          backgroundColor: Colors.grey.shade200,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_rounded), label: "DETAILS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_rounded), label: "DEPARTEMENTS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_document), label: "ARRETS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.text_fields), label: "ATT. & MISSION"),
            BottomNavigationBarItem(
                icon: Icon(Icons.work), label: "REALISATIONS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "HISTORIQUES"),
          ],
        ),
      ),
    );
  }
}
