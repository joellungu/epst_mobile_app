import 'package:epst_app/vues/documents_officiels/arretes_ministeriel.dart';
import 'package:epst_app/vues/documents_officiels/message_phonique.dart';
import 'package:epst_app/vues/documents_officiels/notes_circulaire.dart';
import 'package:epst_app/vues/documents_officiels/notifications_arretes.dart';
import 'package:epst_app/vues/ige/palmares/demande_palmares.dart';
import 'package:epst_app/vues/mutuelle/mutuelle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'attestation_reussite/attestation_reussit.dart';
import 'demande_transfere/transfere.dart';
import 'demande_identification/identification.dart';
import 'documents_certificatifs/documents.dart';
import 'resultat_exetat/resultat_exetat.dart';
import 'sernie/sernie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Ige extends StatefulWidget {
  String? titre;
  //
  bool? appB;
  //
  Ige({Key? key, this.titre, this.appB = false}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _Ige();
  }
}

class _Ige extends State<Ige> {
  //
  bool _isConnected = false;
  late Connectivity _connectivity;
  late final Stream<ConnectivityResult> _stream;
  //

  Future<void> _checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    final connected = results.any((r) => r != ConnectivityResult.none);
    setState(() => _isConnected = connected);

    // On écoute les changements en direct
    _connectivity.onConnectivityChanged.listen((results) {
      final connected = results.any((r) => r != ConnectivityResult.none);
      setState(() => _isConnected = connected);
    });
  }

  //
  List services = [
    // "Consultation résultats d'examen d'etat", //Get.to(const ResultatExetat());
    // "Documents certificatifs", //Get.to(Documents(titre: "Documents"));
    // "Palmarès exetat", //Get.to(const DemandePalmares());
    "Identification epreuves certificative", //Get.to(Identification(
    //  titre: "Identification epreuves certificative"));
    "Identification SERNIE", //Get.to(Sernie(titre: "Identification SERNIE"));
    "Transfère élève", //Get.to(Transfere(titre: "Demande de transfère",));
    "Identification école", //Get.to(AttestationReussit(titre: "Attestation de réussite"));
    "M.E.S.P", //Get.to(Mutuelle(titre: "Mutuelle"));
    //"",
  ];

  // Icônes distinctes et cohérentes avec chaque service ci-dessus
  final List<IconData> serviceIcons = [
    Icons.badge_outlined,
    Icons.fingerprint_outlined,
    Icons.swap_horiz_outlined,
    Icons.home_work_outlined,
    Icons.health_and_safety_outlined,
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
  void initState() {
    //
    _connectivity = Connectivity();
    //
    _checkConnection();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appB!
          ? AppBar(
              title: Text("Services"),
              centerTitle: true,
            )
          : null,
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          children: List.generate(
            services.length,
            (s) {
              //
              return ElevatedButton(
                onPressed: () {
                  //
                  // if (s == 0) {
                  //   Get.to(const ResultatExetat());
                  // }
                  // if (s == 1) {
                  //   Get.to(Documents(titre: "Documents"));
                  // }
                  // if (s == 2) {
                  //   Get.to(const DemandePalmares());
                  // }
                  if (s == 0) {
                    Get.to(Identification(
                        titre: "Identification epreuves certificative"));
                  }
                  if (s == 1) {
                    Get.to(Sernie(titre: "Identification SERNIE"));
                  }
                  if (s == 2) {
                    Get.to(Transfere(
                      titre: "Demande de transfère",
                    ));
                  }
                  if (s == 3) {
                    Get.to(AttestationReussit(
                      titre: "Attestation de réussite",
                      localData: _isConnected,
                    ));
                  }
                  if (s == 4) {
                    Get.to(Mutuelle(titre: "Mutuelle"));
                  }
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              serviceIcons[s % serviceIcons.length],
                              size: 26,
                              color: Colors.black87,
                            ),
                          ),
                          Image.asset(
                            "assets/logo_min_edu_nc.png",
                            height: 36,
                            width: 90,
                            fit: BoxFit.contain,
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
