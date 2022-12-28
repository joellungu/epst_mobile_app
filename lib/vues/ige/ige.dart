import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/cours/arretes_ministeriel.dart';
import 'package:epst_app/vues/cours/message_phonique.dart';
import 'package:epst_app/vues/cours/notes_circulaire.dart';
import 'package:epst_app/vues/cours/notifications_arretes.dart';
import 'package:epst_app/vues/ige/palmares/demande_palmares.dart';
import 'package:epst_app/vues/ige/demande_transfere/demande_transfere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'demande_transfere/transfere.dart';
import 'documents_certificatifs/demande_documents.dart';
import 'demande_identification/demande_identification.dart';
import 'demande_identification/identification.dart';
import 'documents_certificatifs/documents.dart';

class Ige extends StatefulWidget {
  String? titre;
  //
  Ige({this.titre});
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
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titre}"),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
        children: [
          ElevatedButton(
            onPressed: () {
              //
              Get.to(DemandePalmares());
            },
            style: ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Palmarès exetat",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
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
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          //                   color: Colors.white,
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Documents certificatifs",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: taille,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Transfere(
                titre: "Demande de transfère",
              ));
            },
            style: ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
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
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Identification(titre: "Demande d'identification"));
            },
            style: ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Identification élève",
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(MessagePhonique(titre: "Message phonique"));
            },
            style: ButtonStyle(
                /*
                backgroundColor: MaterialStateProperty.all(
                Colors.green.shade700,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd),
                      child: Image.asset(
                        "assets/LOGO-MINEPST-BON.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Attestation de reussite exetat",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: taille,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
//
}
