import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/cours/arretes_ministeriel.dart';
import 'package:epst_app/vues/cours/message_phonique.dart';
import 'package:epst_app/vues/cours/notes_circulaire.dart';
import 'package:epst_app/vues/cours/notifications_arretes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Ige extends StatefulWidget{
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
  double st = 25;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titre}"),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: [
          ElevatedButton(
            onPressed: () {
              //
              Get.to(ArretesMinisteriel(titre: "Arretés ministeriels"));
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
                  /*
                  Expanded(
                    flex: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.dock_sharp,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  */
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Demande palmarès",
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
          ElevatedButton(
            onPressed: () {
              //
              Get.to(NotificationsArretes(titre: "Notifications arretés"));
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
                  /*
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.notifications,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  */
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Demande Note d'acquis de droit",
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
          ElevatedButton(
            onPressed: () {
              //
              Get.to(NotesCirculaire(titre: "Notes circulaires"));
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
                  /*
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.note_alt,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  */
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Demande diplome",
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
                  /*
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.keyboard_voice,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  */
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Demande transfère",
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
                  /*
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.keyboard_voice,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  */
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Vérification document",
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