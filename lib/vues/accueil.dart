import 'dart:convert';
import 'package:epst_app/politique.dart';
import 'package:epst_app/vues/formation/formation.dart';
import 'package:epst_app/vues/ige/ige.dart';
import 'package:epst_app/vues/plainte/depotplainte.dart';
import 'package:epst_app/vues/actualite/live.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/vues/sg/sg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'e_sige/e_sige.dart';
import 'identification/verification.dart';
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
  int currentIndex = 0;

  List liste = [
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
  ];

  @override
  void initState() {
    listeIcons = [
      // Image.asset(
      //   "assets/FOAD.jpg",
      //   color: Colors.blue,
      //   colorBlendMode: BlendMode.color,
      // ),

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
      //
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
      // Image.asset(
      //   "assets/LOGO-MINEPST-BON.png",
      //   color: Colors.white,
      //   colorBlendMode: BlendMode.dst,
      //   height: 100,
      //   width: 100,
      // ),
      // //
      // Image.asset(
      //   "assets/LOGO-MINEPST-BON.png",
      //   // color: Colors.blue,
      //   // colorBlendMode: BlendMode.color,
      // ),

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
                padding: const EdgeInsets.all(20),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8,
                children: List.generate(liste.length, (index) {
                  return InkWell(
                    onTap: () {
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
                      // else if (index == 5) {
                      //   return Listing(
                      //     titre: liste[index],
                      //   );
                      // }
                      if (index == 3) {
                        Get.to(
                          Reforme(
                            titre: liste[index],
                          ),
                        );
                      }
                      // else if (index == 9) {
                      //   //print("Je suis le cours...");Ige,Ige
                      //   return Formation(
                      //     titre: liste[index],
                      //   );
                      // }
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
                      if (index == 6) {
                        //print("Je suis le cours...");Ige,Ige
                        Get.to(
                          LiveStream(
                            titre: liste[index],
                          ),
                        );
                      }
                      // if (index == 7) {
                      //   //print("Je suis le cours...");Ige,Ige
                      //   //Mutuelle
                      //   Get.to(
                      //     LiveStream(titre: "Actualités"),
                      //   );
                      // }
                      // else {
                      //   //
                      //   //return Container();
                      //   return LiveStream(titre: "Actualité");
                      // }
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
                              child:
                                  //index != 1
                                  //?
                                  Container(
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
                              //: Lottie.asset(
                              //  'assets/Animation - 1719837917526.json'),
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
                                  text: "", // index == 1 ? "MGP\n" :
                                  children: [
                                    TextSpan(
                                      text: liste[index],
                                      style: TextStyle(
                                        fontSize: index == 6
                                            ? 12
                                            : index == 7
                                                ? 12
                                                : index == 1
                                                    ? 13
                                                    : 13,
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
              ? NotificationsScolaires()
              : currentIndex == 1
                  ? Formation(titre: "Formation à distance")
                  : currentIndex == 3
                      ? Ige(
                          titre: "Demande document service",
                        )
                      : currentIndex == 4
                          ? Container()
                          : PolitiqueConfidenciel(false),
      //
      bottomNavigationBar: BottomNavigationBar(
        onTap: (e) {
          //
          print("e: $e");
          setState(() {
            currentIndex = e;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        //backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          color: Colors.grey.shade300,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        items: [
          BottomNavigationBarItem(
            label: "Annonces",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 0
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset("assets/svg/SolarChatUnreadOutline.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ),
          BottomNavigationBarItem(
            label: "Ma classe",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 1
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset("assets/svg/SolarBook2Outline.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ),
          BottomNavigationBarItem(
            label: "EDU & Moi",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 2
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset("assets/svg/SolarHomeAngleOutline.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ),
          BottomNavigationBarItem(
            label: "Services",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 3
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset("assets/svg/SolarClipboardTextLinear.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ),
          BottomNavigationBarItem(
            label: "Parcours scolaire",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 4
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                  "assets/svg/SolarSquareAcademicCap2Linear.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ),
          BottomNavigationBarItem(
            label: "Politique de confidentialité",
            icon: Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: currentIndex == 5
                    ? Colors.blue.shade100
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset("assets/svg/SolarChecklistBold.svg",
                  semanticsLabel: 'Acme Logo'),
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
