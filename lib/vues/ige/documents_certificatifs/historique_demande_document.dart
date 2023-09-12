import 'package:accordion/accordion.dart';
import 'package:epst_app/vues/ige/documents_certificatifs/document_certificatif_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoriqueDemandeDocument extends StatefulWidget {
  const HistoriqueDemandeDocument({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoriqueDemandeDocument();
  }
}

class _HistoriqueDemandeDocument extends State<HistoriqueDemandeDocument> {
  //
  DemandeDocumentController demandeDocumentController = Get.find();
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
    l.value = box.read("historique_document") ?? [];
    l.value = l.value.reversed.toList();
    print(box.read("historique"));
    //
  }

  //
  Future<Map> getStatus(String id) async {
    return demandeDocumentController.getStatus(id);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Historique document"),
        ),
        body: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
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
                  "${e['documenrDemande']} du ${e['datedemande'] ?? ''}",
                  style: const TextStyle(
                      //datedemande
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
                          "adresse: ${e['adresse']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
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
                        "ecole: ${e['ecole']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEcole: ${e['provinceEcole']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEducationnel: ${e['provinceEducationnel']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "option: ${e['option']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "annee: ${e['annee']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "documenrDemandecode: ${e['documenrDemandecode']}",
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.normal),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "document Demande: ${e['documenrDemande']}",
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
                                      ? const Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Validation: Validé",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Passez à l'imprimerie de Kinshasa",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ],
                                        )
                                      : v['valider'] == 2
                                          ? Column(
                                              children: [
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation: Refusé",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Raison: ${v['raison']}",
                                                    style:
                                                        const TextStyle(fontSize: 15),
                                                  ),
                                                )
                                              ],
                                            )
                                          : v['valider'] == 3
                                              ? const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation: Expiré",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                )
                                              : const Align(
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
        ));
  }
}
