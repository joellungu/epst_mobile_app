import 'dart:convert';
import 'package:epst_app/vues/epst_kelasi/epst_kelasi.dart';
import 'package:epst_app/vues/formation/formation.dart';
import 'package:epst_app/vues/ige/ige.dart';
import 'package:epst_app/vues/plainte/depotplainte.dart';
import 'package:epst_app/vues/listing.dart';
import 'package:epst_app/vues/actualite/live.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/vues/sg/sg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'e_sige/e_sige.dart';
import 'identification/verification.dart';
import 'mutuelle/mutuelle.dart';
import 'reforme/reforme.dart';
import 'chat.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  double si = 60;
  List listeIcons = [];

  List liste = [
    "EPST actualités",
    "Chat avec agent EPST",
    "Magazine de l’EPST",
    "Dépôt plainte",
    "Réformes EPST",
    "DINACOPE Listing",
    "Sécretariat général & Directions centrales",
    "DIGE\nE-SIGE EPST",
    "Demande Exetat, documents EPST",
    "Formation à distance",
    "Mutuelle de santé",
    "EPST Kelasi",
  ];

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    listeIcons = [
      const Icon(
        Icons.language,
        size: 70,
      ), //
      Image.asset(
        "assets/images-n.png",
        color: Colors.blue,
        colorBlendMode: BlendMode.colorDodge,
      ),
      Image.asset(
        "assets/logo-mag.png",
        color: Colors.blue,
        colorBlendMode: BlendMode.color,
      ),

      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        // color: Colors.blue,
        // colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        // color: Colors.blue,
        // colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        //color: Colors.blue,
        //colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        fit: BoxFit.fill,
        // color: Colors.blue,
        // colorBlendMode: BlendMode.color,
      ),

      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        color: Colors.white,
        colorBlendMode: BlendMode.dst,
        height: 100,
        width: 100,
      ),
      //
      Image.asset(
        "assets/LOGO-MINEPST-BON.png",
        // color: Colors.blue,
        // colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/FOAD.jpg",
        color: Colors.blue,
        colorBlendMode: BlendMode.color,
      ),
      //
      Image.asset(
        "assets/Logo_MESP_ok.png",
        fit: BoxFit.fill,
        // height: 100,
        // width: 100,
        color: Colors.blue,
        colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/epst_kelasi.png",
        fit: BoxFit.fill,
        height: 100,
        width: 100,
        // color: Colors.blue,
        // colorBlendMode: BlendMode.color,
      ),
    ];
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);

    Source:
    https: //prograide.com/pregunta/68443/flutter--comment-definir-et-verrouiller-lorientation-de-lecran--la-demande
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EPST APP"),
        centerTitle: true,
        elevation: 1,
        actions: [
          PopupMenuButton(onSelected: (e) {
            //Identification
            print(e);
            if (e == 0) {
              Get.to(const Verification());
            }
            //
          }, itemBuilder: (c) {
            return [
              const PopupMenuItem(
                value: 0,
                //onTap: () => Get.to(Identification()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 25,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Identification")
                  ],
                ),
              ),
              // const PopupMenuItem(
              //   value: 1,
              //   //onTap: () => Get.to(Identification()),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Icon(
              //         Icons.person,
              //         size: 25,
              //         color: Colors.blue,
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text("Validation")
              //     ],
              //   ),
              // ),
            ];
          }),
          // IconButton(
          //   onPressed: () {
          //     // Get.to(const ChatPage()); //
          //     Get.to(ChatPage2()); //
          //   },
          //   icon: const Icon(
          //     Icons.more_horiz,
          //   ),
          // )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        childAspectRatio: 0.7,
        children: List.generate(liste.length, (index) {
          return InkWell(
            onTap: () {
              if (index == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Votre nom"),
                        content: SizedBox(
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
                                child: const Text("Commencer"),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    if (index == 0) {
                      return LiveStream(
                        titre: liste[index],
                      );
                    } else if (index == 3) {
                      //
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
                    } else if (index == 9) {
                      //print("Je suis le cours...");Ige,Ige
                      return Formation(
                        titre: liste[index],
                      );
                    } else if (index == 7) {
                      //print("Je suis le cours...");Ige,Ige
                      return Esige(
                        titre: liste[index],
                      );
                    } else if (index == 8) {
                      //print("Je suis le cours...");Ige,Ige
                      return Ige(
                        titre: liste[index],
                      );
                    } else if (index == 6) {
                      //print("Je suis le cours...");Ige,Ige
                      return SecretariaGeneral(
                        titre: liste[index],
                      );
                    } else if (index == 10) {
                      //print("Je suis le cours...");Ige,Ige

                      return Mutuelle(
                        titre: liste[index],
                      );
                    } else {
                      //
                      return EpstKelasi(
                        liste[index],
                      );
                    }
                  }),
                );
              }
            },
            //elevation: 1,
            //color: Colors.white,

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.all(5),
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
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: index == 1 ? "MGP\n" : "",
                          children: [
                            TextSpan(
                              text: liste[index],
                              style: TextStyle(
                                fontSize: index == 6
                                    ? 12
                                    : index == 8
                                        ? 13
                                        : index == 1
                                            ? 10
                                            : 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: const TextStyle(
                            fontSize: 15,
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
