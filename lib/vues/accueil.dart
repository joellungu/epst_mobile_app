import 'dart:convert';
import 'package:epst_app/vues/chat/chat.dart';
import 'package:epst_app/vues/cours/cours.dart';
import 'package:epst_app/vues/formation/formation.dart';
import 'package:epst_app/vues/plainte/depotplainte.dart';
import 'package:epst_app/vues/listing.dart';
import 'package:epst_app/vues/live/live.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reforme/reforme.dart';
import 'chat.dart';
import 'formation/formation_enseignant.dart';

class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  List listeIcons = const [
    Icon(
      Icons.language,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      Icons.list_alt,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      Icons.dashboard,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      CupertinoIcons.bubble_left_bubble_right_fill,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      Icons.people_alt_sharp,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      CupertinoIcons.profile_circled,
      color: Colors.white,
      size: 100,
    ),
    Icon(
      CupertinoIcons.doc_on_clipboard_fill,
      color: Colors.white,
      size: 100,
    ),
  ];

  List liste = [
    "Epst actualités",
    "Depot plainte",
    "Mag EPST",
    "Chat",
    "Reforme de l'EPST",
    "Listing",
    "Formation à distance",
    "Document officiel Epst",
  ];

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EPST APP"),
        centerTitle: true,
        elevation: 1,
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: List.generate(liste.length, (index) {
          return ElevatedButton(
            onPressed: () {
              if (index == 3) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Votre nom"),
                        content: Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextField(
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "Votre nom SVP!",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (textEditingController.text.isNotEmpty) {
                                    var encoded =
                                        utf8.encode(textEditingController.text);
                                    var decoded = utf8.decode(encoded);
                                    print(decoded);

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Chat(
                                            titre: liste[index],
                                            nom: decoded,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: Text("Commencer"),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  if (index == 0) {
                    return LiveStream(
                      titre: liste[index],
                    );
                  } else if (index == 1) {
                    return DepotPlainte(
                      titre: liste[index],
                    );
                  } else if (index == 2) {
                    return Magasine(
                      titre: liste[index],
                    );
                  } else if (index == 5) {
                    return Listing(
                      titre: liste[index],
                    );
                  } else if (index == 4) {
                    return Reforme(
                      titre: liste[index],
                    );
                  } else if (index == 7) {
                    //print("Je suis le cours...");
                    return Coure(
                      titre: liste[index],
                    );
                  } else {
                    //
                    return Formation(
                      titre: liste[index],
                    );
                  }
                }));
              }
            },
            //elevation: 1,
            //color: Colors.white,
            style: const ButtonStyle(
                /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    child: listeIcons[index],
                    decoration: const BoxDecoration(
                      //color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: index == 1 ? "MGP\n" : "",
                        children: [
                          TextSpan(
                            text: liste[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                        style: const TextStyle(
                          fontSize: 20,
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
          );
        }),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>ChatTest());
        },
        child: Icon(Icons.add),
      ),
      */
    );
  }
}
