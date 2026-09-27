import 'dart:convert';

import 'package:epst_app/chats/WaitingScreen.dart';
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

  // Icônes cohérentes avec chaque service (même ordre que `liste`)
  final List<IconData> listeIcons = [
    Icons.chat_outlined, // Chat avec agent EDU-NC
    Icons.newspaper_outlined, // Magazine EDU-NC
    Icons.report_problem_outlined, // MGP dépôt plainte
    Icons.policy_outlined, // Réformes EDU-NC
    Icons.business_outlined, // Sécretariat général
    Icons.bar_chart_outlined, // Statistique de EDU-NC
    Icons.school_outlined, // Consultation résultats d'examen d'etat
    Icons.folder_open_outlined, // Documents certificatifs
    Icons.emoji_events_outlined, // Palmarès exetat
    Icons.badge_outlined, // Identification epreuves certificative
    Icons.fingerprint_outlined, // Identification SERNIE
    Icons.swap_horiz_outlined, // Transfère élève
    Icons.home_work_outlined, // Identification école
    Icons.health_and_safety_outlined, // M.E.S.P
  ];

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
                hintText: "Rechercher un service...",
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
                final String item = filteredItems[index];
                final int realIndex = liste.indexOf(item);
                return ListTile(
                  onTap: () {
                    //
                    if (realIndex == 0) {
                      Get.to(
                        WaitingScreen(),
                      );
                    }
                    if (realIndex == 1) {
                      Get.to(
                        Magasine(
                          titre: item,
                        ),
                      );
                    }
                    if (realIndex == 2) {
                      //
                      Get.to(
                        DepotPlainte(
                          titre: item,
                        ),
                      );
                    }
                    if (realIndex == 3) {
                      Get.to(
                        Reforme(
                          titre: item,
                        ),
                      );
                    }
                    if (realIndex == 4) {
                      //print("Je suis le cours...");Ige,Ige
                      Get.to(
                        SecretariaGeneral(
                          titre: item,
                        ),
                      );
                    }
                    if (realIndex == 5) {
                      //print("Je suis le cours...");Ige,Ige
                      Get.to(
                        Esige(
                          titre: item,
                        ),
                      );
                    }
                    // if (realIndex == 6) {
                    //   //print("Je suis le cours...");Ige,Ige
                    //   Get.to(
                    //     LiveStream(
                    //       titre: item,
                    //     ),
                    //   );
                    // }
                    //
                    if (realIndex == 6) {
                      Get.to(const ResultatExetat());
                    }
                    if (realIndex == 7) {
                      Get.to(Documents(titre: "Documents"));
                    }
                    if (realIndex == 8) {
                      Get.to(const DemandePalmares());
                    }
                    if (realIndex == 9) {
                      Get.to(Identification(
                          titre: "Identification epreuves certificative"));
                    }
                    if (realIndex == 10) {
                      Get.to(Sernie(titre: "Identification SERNIE"));
                    }
                    if (realIndex == 11) {
                      Get.to(Transfere(
                        titre: "Demande de transfère",
                      ));
                    }
                    if (realIndex == 12) {
                      Get.to(
                          AttestationReussit(titre: "Attestation de réussite"));
                    }
                    if (realIndex == 13) {
                      Get.to(Mutuelle(titre: "Mutuelle"));
                    }
                  },
                  leading: Icon(
                    listeIcons[realIndex % listeIcons.length],
                    color: Colors.blue,
                  ),
                  title: Text(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
