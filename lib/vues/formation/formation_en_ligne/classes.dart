import 'package:epst_app/vues/documents_officiels/arretes_ministeriel.dart';
import 'package:epst_app/vues/documents_officiels/message_phonique.dart';
import 'package:epst_app/vues/documents_officiels/notes_circulaire.dart';
import 'package:epst_app/vues/documents_officiels/notifications_arretes.dart';
import 'package:epst_app/vues/ige/palmares/demande_palmares.dart';
import 'package:epst_app/vues/mutuelle/mutuelle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'horaire_cours.dart';

class Classes extends StatefulWidget {
  String? titre;
  //
  Classes({Key? key, this.titre}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _Classes();
  }
}

class _Classes extends State<Classes> {
  //
  List services = [
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
  //
  final Random _random = Random();
  //
  Color generateRandomColor() {
    // Génère une couleur claire
    return Color.fromRGBO(
      _random.nextInt(128) + 127, // Valeur rouge entre 127 et 255
      _random.nextInt(128) + 127, // Valeur verte entre 127 et 255
      _random.nextInt(128) + 127, // Valeur bleue entre 127 et 255
      1,
    );
  }

  //
  double st = 12;
  double taille = 8;
  double pd = 13;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: ExactAssetImage("assets/LOGO-MINEPST-BON.png"),
                ),
                borderRadius: BorderRadius.circular(10),
                //color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1,
          children: List.generate(
            services.length,
            (s) {
              //
              return ElevatedButton(
                onPressed: () {
                  //
                  Get.to(HoraireCours(30));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                  backgroundColor: generateRandomColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: ExactAssetImage(
                                  "assets/LOGO-MINEPST-BON.png",
                                ),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              //color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 7,
                        child: Center(
                          child: Text(
                            services[s],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
//
}
