import 'dart:io';

import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DetailsSG extends StatelessWidget {
  final Map e;
  DetailsSG(this.e, {Key? key}) : super(key: key);
  //
  final RxInt ie = 0.obs;
  //
  String _text(
    Map data,
    List<String> keys, {
    String fallback = 'Non renseigne',
  }) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return fallback;
  }

  List _list(Map data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is List) {
        return value;
      }
    }
    return [];
  }

  String _arreteTexte() {
    final arrete = e['arrete'] ?? e['arretes'];
    if (arrete is Map) {
      return _text(arrete, ['texte', 'text']);
    }
    return 'Non renseigne';
  }

  ImageProvider _profileImage() {
    final localPath = e['localPhotoPath'];
    if (localPath != null && File(localPath.toString()).existsSync()) {
      return FileImage(File(localPath.toString()));
    }
    return NetworkImage("${Connexion.lien}secretariat/photoprofil/${e["id"]}");
  }

  Widget _departmentImage(Map d, int index) {
    final localPath = d['localPhotoPath'];
    if (localPath != null && File(localPath.toString()).existsSync()) {
      return Image.file(
        File(localPath.toString()),
        fit: BoxFit.contain,
      );
    }

    if (d["photo"] == null && d["hasPhoto"] != true && d["id"] == null) {
      return const SizedBox.shrink();
    }

    return Image.network(
      d["id"] != null
          ? "${Connexion.lien}secretariat/departement/photo/${d["id"]}"
          : "${Connexion.lien}secretariat/photo/${e["id"]}/$index",
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final departements = _list(e, ['departements', 'departement']);
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(_text(e, ['sigle'], fallback: 'Secretariat general')),
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
                    _text(e, ['denomination', 'denomition']),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _profileImage(),
                        fit: BoxFit.contain,
                      ),
                    ),
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
                            leading: const Icon(Icons.person),
                            title: const Text("NOM DU RESPONSABLE"),
                            subtitle: Text(_text(e, ['responsable'])),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone_android),
                            title: const Text("TELEPHONE"),
                            subtitle: Text(_text(e, ['telephone'])),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text("EMAIL"),
                            subtitle: Text(_text(e, ['email'])),
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
                    _text(e, ['adresse']),
                  ),
                ],
              )
            : ie.value == 1
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: List.generate(
                      departements.length,
                      (index) {
                        //departements
                        Map d = departements[index];
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
                                (d["photo"] != null ||
                                        d["hasPhoto"] == true ||
                                        d["id"] != null ||
                                        d["localPhotoPath"] != null)
                                    ? Expanded(
                                        flex: 3,
                                        child: _departmentImage(d, index),
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
                                        _text(d, ['responsable']),
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
                                              text: _text(
                                                d,
                                                ['nom', 'departement'],
                                              ),
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
                          Text(_arreteTexte())
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
                              Text(_text(e, ['attributionMission']))
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
                                  Text(_text(e, ['realisation']))
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
                                  Text(_text(e, ['historique']))
                                  //HtmlWidget("""${e['historique']}"""),
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
