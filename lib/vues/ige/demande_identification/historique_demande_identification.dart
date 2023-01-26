import 'package:accordion/accordion.dart';
import 'package:epst_app/vues/identification/identification_controller.dart';
import 'package:epst_app/vues/mutuelle/mutuelle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoriqueDemandeIdentification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoriqueDemandeIdentification();
  }
}

class _HistoriqueDemandeIdentification
    extends State<HistoriqueDemandeIdentification> {
  //
  MutuelleController mutuelleController = Get.find();
  IdentificationController identificationController = Get.find();
  TextEditingController cenome = TextEditingController();
  var box = GetStorage();
  RxList l = RxList();

  //
  @override
  void initState() {
    //
    //mutuelleController.
    //
    super.initState();
    //
    l.value = box.read("historique_identification") ?? [];
    l.value = l.value.reversed.toList();
    print(box.read("historique_identification"));
    //
  }

  //
  Future<int> getStatus(String id) async {
    return identificationController.getStatus(id, false);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Validation"),
        ),
        body: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          children: List.generate(l.length, (index) {
            Map e = l[index];
            String dd = "${e['jour']}".split('.')[0];
            //
            print(e);
            //
            RxInt show = 0.obs;
            //
            return AccordionSection(
                header: Text(
                  "${e['nom']} ${e['postnom']} ${e['prenom']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                content: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "id: ${e['id']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nom: ${e['nom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Postnom: ${e['postnom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prenom: ${e['prenom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "sexe: ${e['sexe']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lieuNaissance: ${e['lieuNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "dateNaissance: ${e['dateNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "telephone: ${e['telephone']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "nompere: ${e['nompere']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "nommere: ${e['nommere']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "adresse: ${e['adresse']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "provinceOrigine: ${e['provinceOrigine']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecole: ${e['ecole']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEcole: ${e['provinceEcole']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEducationnel: ${e['provinceEducationnel']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "option: ${e['option']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "annee: ${e['annee']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    /*
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Identification: ${e['typeIdentification']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    */
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "typeIdentification: ${e['typeIdentification']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getStatus("${e['id']}"),
                        builder: (context, t) {
                          if (t.hasData) {
                            int v = t.data as int;
                            print("Valider ou: $v");
                            show.value = v;
                            //setState((){});
                            return Container(
                              height: 100,
                              child: Column(
                                children: [
                                  v == 1
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Validation: Validé",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )
                                      : v == 2
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Validation: Refusé",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            )
                                          : v == 3
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation: Expiré",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                )
                                              : Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation: En attente",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            );
                            //return
                          } else if (t.hasError) {
                            return Text("...");
                          }

                          return Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ));
            /*
          return ListTile(
            leading: Icon(Icons.file_present_rounded),
            title: Text("${e['services']}"),
            //${e['nom']} ${e['postnom']} ${e['prenom']}
            subtitle: Text("${e['matricule']} ${e['direction']} / ${e['jour'] ?? ''}"),
            trailing: FutureBuilder(
              future: getStatus("${e['matricule']}"),
              builder: (context, t){
                if(t.hasData){
                  int v = t.data as int;
                  return v == 1 ? Text("Validé") : v == 2 ? Text("Refusé") : Text("En attente");
                }else if(t.hasError){
                  return Text("...");
                }

                return Container(height: 50,width: 50,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),);
              },
            ),
          );
          */
          }),
        ));
  }
}
