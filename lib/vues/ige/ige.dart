import 'package:epst_app/vues/documents_officiels/arretes_ministeriel.dart';
import 'package:epst_app/vues/documents_officiels/message_phonique.dart';
import 'package:epst_app/vues/documents_officiels/notes_circulaire.dart';
import 'package:epst_app/vues/documents_officiels/notifications_arretes.dart';
import 'package:epst_app/vues/ige/palmares/demande_palmares.dart';
import 'package:epst_app/vues/mutuelle/mutuelle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'attestation_reussite/attestation_reussit.dart';
import 'demande_transfere/transfere.dart';
import 'demande_identification/identification.dart';
import 'documents_certificatifs/documents.dart';
import 'resultat_exetat/resultat_exetat.dart';
import 'sernie/sernie.dart';

class Ige extends StatefulWidget {
  String? titre;
  //
  Ige({Key? key, this.titre}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _Ige();
  }
}

class _Ige extends State<Ige> {
  @override
  void initState() {}
  //
  double st = 12;
  double taille = 8;
  double pd = 13;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titre}"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
        children: [
          ElevatedButton(
            onPressed: () {
              //
              Get.to(const ResultatExetat());
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0), //
                    decoration: const BoxDecoration(
                      //color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/LOGO-MINEPST-BON.png",
                      color: Colors.blue,
                      colorBlendMode: BlendMode.color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Consultation résultats d'examen d'etat",
                        children: [
                          TextSpan(
                            text: "",
                            style: TextStyle(
                              fontSize: taille,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                        style: TextStyle(
                          fontSize: st,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     //
          //     Get.to(NotificationsArretes(titre: "Notifications arretés"));
          //   },
          //   style: ButtonStyle(
          //       /*
          //       backgroundColor: MaterialStateProperty.all(
          //       Colors.green.shade700,
          //     ),
          //     */
          //       ),
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           flex: 5,
          //           child: Container(
          //             alignment: Alignment.center,
          //             padding: EdgeInsets.all(pd),
          //             child: Image.asset(
          //               "assets/LOGO-MINEPST-BON.png",
          //               color: Colors.blue,
          //               colorBlendMode: BlendMode.color,
          //             ), //
          //             decoration: const BoxDecoration(
          //                 //color: Colors.blue,
          //                 borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(10),
          //               topRight: Radius.circular(10),
          //             )),
          //           ),
          //         ),
          //         Expanded(
          //           flex: 5,
          //           child: Container(
          //             padding: EdgeInsets.only(bottom: 15),
          //             alignment: Alignment.center,
          //             child: RichText(
          //               textAlign: TextAlign.center,
          //               text: TextSpan(
          //                 text: "Note d'acquis de droit",
          //                 children: [TextSpan(text: "")],
          //                 style: TextStyle(
          //                   fontSize: st,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             ),
          //             decoration: const BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             )),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Documents(titre: "Documents"));
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0), //
                    decoration: const BoxDecoration(
                      //color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/LOGO-MINEPST-BON.png",
                      color: Colors.blue,
                      colorBlendMode: BlendMode.color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Documents certificatifs ",
                        children: [
                          // TextSpan(
                          //   text: "(Attestations, diplome, NAD ...)",
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black,
                          //   ),
                          // )
                        ],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(const DemandePalmares());
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0), //
                      decoration: const BoxDecoration(
                        //color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Palmarès exetat",
                          children: const [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              //
              Get.to(Identification(
                  titre: "Identification epreuves certificative"));
              //
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0), //
                      decoration: const BoxDecoration(
                        //color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Identification epreuves certificative",
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Sernie(titre: "Identification SERNIE"));
            },
            style: const ButtonStyle(
                /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center, //
                    decoration: const BoxDecoration(
                      //color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/LOGO-MINEPST-BON.png",
                      color: Colors.blue,
                      colorBlendMode: BlendMode.color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Identification SERNIE",
                        children: [
                          TextSpan(
                            text: "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Transfere(
                titre: "Demande de transfère",
              ));
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center, //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Transfère élève",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: taille,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              //
              Get.to(AttestationReussit(titre: "Attestation de réussite"));
            },
            style: const ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center, //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Fiche de paie",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: taille,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Mutuelle(titre: "Mutuelle"));
            },
            style: const ButtonStyle(
                /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center, //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                      child: Image.asset(
                        "assets/Logo_MESP_ok.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "M.E.S.P",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     //
          //     Get.to(NotificationsArretes(titre: "Notifications arretés"));
          //   },
          //   style: const ButtonStyle(
          //       /*
          //     backgroundColor: MaterialStateProperty.all(
          //       Colors.blue.shade400,
          //     ),
          //     */
          //       ),
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           flex: 7,
          //           child: Container(
          //             alignment: Alignment.center,
          //             child: Image.asset(
          //               "assets/LOGO-MINEPST-BON.png",
          //               color: Colors.blue,
          //               colorBlendMode: BlendMode.color,
          //             ), //
          //             decoration: const BoxDecoration(
          //               //color: Colors.blue,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(10),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(bottom: 10),
          //           alignment: Alignment.center,
          //           child: RichText(
          //             textAlign: TextAlign.center,
          //             text: const TextSpan(
          //               text: "Notifications arretés",
          //               children: [
          //                 TextSpan(
          //                   text: "",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.black,
          //                   ),
          //                 )
          //               ],
          //               style: TextStyle(
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //           decoration: const BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     //
          //     Get.to(NotesCirculaire(titre: "Notes circulaires"));
          //   },
          //   style: const ButtonStyle(
          //       /*
          //     backgroundColor: MaterialStateProperty.all(
          //       Colors.blue.shade400,
          //     ),
          //     */
          //       ),
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           flex: 7,
          //           child: Container(
          //             alignment: Alignment.center,
          //             child: Image.asset(
          //               "assets/LOGO-MINEPST-BON.png",
          //               color: Colors.blue,
          //               colorBlendMode: BlendMode.color,
          //             ), //
          //             decoration: const BoxDecoration(
          //               //color: Colors.blue,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(10),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(bottom: 10),
          //           alignment: Alignment.center,
          //           child: RichText(
          //             textAlign: TextAlign.center,
          //             text: const TextSpan(
          //               text: "Notes circulaires",
          //               children: [
          //                 TextSpan(
          //                   text: "",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.black,
          //                   ),
          //                 )
          //               ],
          //               style: TextStyle(
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //           decoration: const BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     //
          //     Get.to(MessagePhonique(titre: "Message phonique"));
          //   },
          //   style: const ButtonStyle(
          //       /*
          //     backgroundColor: MaterialStateProperty.all(
          //       Colors.blue.shade400,
          //     ),
          //     */
          //       ),
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           flex: 7,
          //           child: Container(
          //             alignment: Alignment.center,
          //             child: Image.asset(
          //               "assets/LOGO-MINEPST-BON.png",
          //               color: Colors.blue,
          //               colorBlendMode: BlendMode.color,
          //             ), //
          //             decoration: const BoxDecoration(
          //               //color: Colors.blue,
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(10),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(bottom: 10),
          //           alignment: Alignment.center,
          //           child: RichText(
          //             textAlign: TextAlign.center,
          //             text: const TextSpan(
          //               text: "Message phonique",
          //               children: [
          //                 TextSpan(
          //                   text: "",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.black,
          //                   ),
          //                 )
          //               ],
          //               style: TextStyle(
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //           decoration: const BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          //
        ], //
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
//
}
