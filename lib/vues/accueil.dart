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
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'e_sige/e_sige.dart';
import 'formation/foad.dart';
import 'identification/verification.dart';
import 'mutuelle/mutuelle.dart';
import 'notifications_scolaires/notifications_scolaires.dart';
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
  //
  int currentIndex = 2;

  List liste = [
    "Formation à distance",
    "Chat avec agent EPST",
    "Magazine de l'EPST",
    "Dépôt plainte",
    "Réformes EPST",
    //"DINACOPE Listing",
    "Sécretariat général", //& Directions centrales
    "Statistique\nde EPST",
    "Demande docs et services d'EDUCATION",
    "Actualilé",
    //"Mutuelle de santé",
    //"EPST Kelasi",
  ];

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    listeIcons = [
      Image.asset(
        "assets/FOAD.jpg",
        color: Colors.blue,
        colorBlendMode: BlendMode.color,
      ),
      Image.asset(
        "assets/images-n.png",
        color: Colors.blue,
        colorBlendMode: BlendMode.colorDodge,
      ),
      // Image.asset(
      //   "assets/LOGO-MINEPST-BON.png",
      //   // color: Colors.blue,
      //   // colorBlendMode: BlendMode.color,
      // ), //
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
      //
      Image.asset(
        "assets/Logo_MESP_ok.png",
        fit: BoxFit.fill,
        // height: 100,
        // width: 100,
        color: Colors.blue,
        colorBlendMode: BlendMode.color,
      ),
      // Image.asset(
      //   "assets/epst_kelasi.png",
      //   fit: BoxFit.fill,
      //   height: 100,
      //   width: 100,
      //   // color: Colors.blue,
      //   // colorBlendMode: BlendMode.color,
      // ),
    ];
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);

    //Source:
    //https: //prograide.com/pregunta/68443/flutter--comment-definir-et-verrouiller-lorientation-de-lecran--la-demande
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EDUCATION APP",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
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
      body: currentIndex == 2
          ? Center(
              child: GridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
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
                              return Formation(titre: "Formation à distance");
                              //const FOAD();
                            } else if (index == 2) {
                              return Magasine(
                                titre: liste[index],
                              );
                            } else if (index == 3) {
                              //
                              return DepotPlainte(
                                titre: liste[index],
                              );
                            }
                            // else if (index == 5) {
                            //   return Listing(
                            //     titre: liste[index],
                            //   );
                            // }
                            else if (index == 4) {
                              return Reforme(
                                titre: liste[index],
                              );
                            }
                            // else if (index == 9) {
                            //   //print("Je suis le cours...");Ige,Ige
                            //   return Formation(
                            //     titre: liste[index],
                            //   );
                            // }
                            else if (index == 5) {
                              //print("Je suis le cours...");Ige,Ige
                              return SecretariaGeneral(
                                titre: liste[index],
                              );
                            } else if (index == 6) {
                              //print("Je suis le cours...");Ige,Ige
                              return Esige(
                                titre: liste[index],
                              );
                            } else if (index == 7) {
                              //print("Je suis le cours...");Ige,Ige
                              return Ige(
                                titre: liste[index],
                              );
                            } else if (index == 8) {
                              //print("Je suis le cours...");Ige,Ige
                              //Mutuelle
                              return LiveStream(titre: "Actualités");
                            } else {
                              //
                              //return Container();
                              return LiveStream(titre: "Actualité");
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
                            child: index != 0
                                ? Container(
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
                                  )
                                : Lottie.asset(
                                    'assets/Animation - 1719837917526.json'),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
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
                                  text: index == 1 ? "MGP\n" : "",
                                  children: [
                                    TextSpan(
                                      text: liste[index],
                                      style: TextStyle(
                                        fontSize: index == 6
                                            ? 12
                                            : index == 7
                                                ? 12
                                                : index == 1
                                                    ? 12
                                                    : 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
            )
          : currentIndex == 0
              ? const NotificationsScolaires()
              : currentIndex == 1
                  ? Formation(titre: "Formation à distance")
                  : currentIndex == 3
                      ? Ige(
                          titre: "Demande document service",
                        )
                      : Container(),
      //
      bottomNavigationBar: BottomNavigationBar(
        onTap: (e) {
          //
          setState(() {
            currentIndex = e;
          });
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            label: "Annonces",
            icon: Icon(
              Icons.notifications,
            ),
          ),
          BottomNavigationBarItem(
            label: "Ma classe",
            icon: Icon(
              Icons.book,
            ),
          ),
          BottomNavigationBarItem(
            label: "Accueil",
            icon: Icon(
              Icons.home_filled,
            ),
          ),
          BottomNavigationBarItem(
            label: "Services",
            icon: Icon(
              Icons.file_download,
            ),
          ),
          BottomNavigationBarItem(
            label: "Paramettre",
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
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
