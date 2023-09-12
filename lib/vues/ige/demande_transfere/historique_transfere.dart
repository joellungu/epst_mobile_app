import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'transfere_controller.dart';

class HistoriqueTransfere extends StatefulWidget {
  const HistoriqueTransfere({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoriqueTransfere();
  }
}

class _HistoriqueTransfere extends State<HistoriqueTransfere> {
  //
  TransfereController transfereController = Get.find();
  //IdentificationController identificationController = Get.find();
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
    l.value = box.read("historique_transfere") ?? [];
    l.value = l.value.reversed.toList();
    print(box.read("historique_transfere"));
    //
  }

  //
  Future<Map> getStatus(String id) async {
    return transfereController.getStatus(id);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validation"),
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
          RxInt show = 0.obs;
          //
          return AccordionSection(
              header: Text(
                "${e['nom']} ${e['postnom']} ${e['prenom']}",
                style: const TextStyle(
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
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom: ${e['nom']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Postnom: ${e['postnom']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Prenom: ${e['prenom']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "sexe: ${e['sexe']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lieuNaissance: ${e['lieuNaissance']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "dateNaissance: ${e['dateNaissance']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "telephone: ${e['telephone']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "nompere: ${e['nompere']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "nommere: ${e['nommere']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Téléphone: ${e['telephone']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "adresse: ${e['adresse']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "option avant: ${e['option_avant']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "option apres: ${e['option_apres']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceOrigine: ${e['provinceOrigine']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecole provenance: ${e['ecoleProvenance']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecoleProvenanceProv: ${e['ecoleProvenanceProv']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecoleProvenanceDistric: ${e['ecoleProvenanceDistric']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecoleDestination: ${e['ecoleDestination']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecoleDestinationProv: ${e['ecoleDestinationProv']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ecoleDestinationDistric: ${e['ecoleDestinationDistric']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "datedemande: ${e['datedemande'] ?? ''}",
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
                          Map v = t.data as Map;
                          print("Valider ou: $v");
                          show.value = v['valider'];
                          //setState((){});
                          return SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                v['valider'] == 1
                                    ? const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Validation: Validé",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    : v['valider'] == 2
                                        ? Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Validation: Refusé\nRaison: ${v['raison']}",
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : v['valider'] == 3
                                            ? const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Validation: Expiré",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              )
                                            : const Align(
                                                alignment: Alignment.centerLeft,
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
                          return const Text("...");
                        }

                        return Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
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
      ),
    );
  }
}
