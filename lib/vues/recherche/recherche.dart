import 'dart:convert';

import 'package:epst_app/vues/actualite/live.dart';
import 'package:epst_app/vues/chat.dart';
import 'package:epst_app/vues/e_sige/e_sige.dart';
import 'package:epst_app/vues/ige/attestation_reussite/attestation_reussit.dart';
import 'package:epst_app/vues/ige/demande_identification/identification.dart';
import 'package:epst_app/vues/ige/demande_transfere/transfere.dart';
import 'package:epst_app/vues/ige/documents_certificatifs/documents.dart';
import 'package:epst_app/vues/ige/palmares/demande_palmares.dart';
import 'package:epst_app/vues/ige/resultat_exetat/resultat_exetat.dart';
import 'package:epst_app/vues/ige/sernie/sernie.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/vues/mutuelle/mutuelle.dart';
import 'package:epst_app/vues/plainte/depotplainte.dart';
import 'package:epst_app/vues/reforme/reforme.dart';
import 'package:epst_app/vues/sg/sg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  //const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> liste = [
    //"Formation à distance",
    "Chat avec agent EDU-NC",
    //"",
    "Magazine EDU-NC",
    "MGP\ndépôt plainte",
    "Réformes EDU-NC",
    //"DINACOPE Listing",
    "Sécretariat général", //& Directions centrales
    "Statistique\nde EDU-NC",
    //"Demande docs et services d'EDUCATION",
    //"Actualilé",
    //"Mutuelle de santé",
    //"EPST Kelasi",
    //
    "Consultation résultats d'examen d'etat", //Get.to(const ResultatExetat());
    "Documents certificatifs", //Get.to(Documents(titre: "Documents"));
    "Palmarès exetat", //Get.to(const DemandePalmares());
    "Identification epreuves certificative", //Get.to(Identification(
    //  titre: "Identification epreuves certificative"));
    "Identification SERNIE", //Get.to(Sernie(titre: "Identification SERNIE"));
    "Transfère élève", //Get.to(Transfere(titre: "Demande de transfère",));
    "Identification école", //Get.to(AttestationReussit(titre: "Attestation de réussite"));
    "M.E.S.P", //Get.to(Mutuelle(titre: "Mutuelle"));
    //"",
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    final List<String> filteredItems = liste
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recherche"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un fruit...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    //
                    if (index == 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            //
                            TextEditingController textEditingController =
                                TextEditingController();
                            //
                            return AlertDialog(
                              title: const Text("Votre nom"),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextField(
                                      controller: textEditingController,
                                      decoration: const InputDecoration(
                                        hintText: "Votre nom SVP!",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (textEditingController
                                            .text.isNotEmpty) {
                                          var encoded = utf8.encode(
                                              textEditingController.text);
                                          var decoded = utf8.decode(encoded);
                                          print(decoded);
                                          //

                                          Get.back();

                                          Get.to(
                                            Chat(
                                              titre: liste[index],
                                              nom: decoded,
                                            ),
                                          );
                                          //
                                          //textEditingController.clear();
                                        }
                                      },
                                      child: const Text("Commencer"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    if (index == 1) {
                      Get.to(
                        Magasine(
                          titre: liste[index],
                        ),
                      );
                    }
                    if (index == 2) {
                      //
                      Get.to(
                        DepotPlainte(
                          titre: liste[index],
                        ),
                      );
                    }
                    if (index == 3) {
                      Get.to(
                        Reforme(
                          titre: liste[index],
                        ),
                      );
                    }
                    if (index == 4) {
                      //print("Je suis le cours...");Ige,Ige
                      Get.to(
                        SecretariaGeneral(
                          titre: liste[index],
                        ),
                      );
                    }
                    if (index == 5) {
                      //print("Je suis le cours...");Ige,Ige
                      Get.to(
                        Esige(
                          titre: liste[index],
                        ),
                      );
                    }
                    // if (index == 6) {
                    //   //print("Je suis le cours...");Ige,Ige
                    //   Get.to(
                    //     LiveStream(
                    //       titre: liste[index],
                    //     ),
                    //   );
                    // }
                    //
                    if (index == 6) {
                      Get.to(const ResultatExetat());
                    }
                    if (index == 7) {
                      Get.to(Documents(titre: "Documents"));
                    }
                    if (index == 8) {
                      Get.to(const DemandePalmares());
                    }
                    if (index == 9) {
                      Get.to(Identification(
                          titre: "Identification epreuves certificative"));
                    }
                    if (index == 10) {
                      Get.to(Sernie(titre: "Identification SERNIE"));
                    }
                    if (index == 11) {
                      Get.to(Transfere(
                        titre: "Demande de transfère",
                      ));
                    }
                    if (index == 12) {
                      Get.to(
                          AttestationReussit(titre: "Attestation de réussite"));
                    }
                    if (index == 13) {
                      Get.to(Mutuelle(titre: "Mutuelle"));
                    }
                  },
                  leading: const Icon(Icons.menu),
                  title: Text(filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
