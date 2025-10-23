import 'dart:async';
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:epst_app/vues/actualite/video_en_ligne.dart';
import 'package:epst_app/vues/chat.dart';
import 'package:epst_app/vues/ige/documents_certificatifs/documents.dart';
import 'package:epst_app/vues/ige/ige.dart';
import 'package:epst_app/vues/ige/resultat_exetat/resultat_exetat.dart';
import 'package:epst_app/vues/magasin/accueil_mag.dart';
import 'package:epst_app/vues/plainte/depotplainte.dart';
import 'package:epst_app/vues/sg/accueil_sg.dart';
import 'package:flutter/material.dart';
import 'package:epst_app/vues/actualite/site.dart';
import 'package:get/get.dart';
import 'package:epst_app/vues/actualite/clin_oeil.dart';
import 'package:epst_app/vues/actualite/dinacope.dart';
import 'package:epst_app/vues/actualite/direct_eductivi.dart';

class NotificationsScolaires extends StatefulWidget {
  const NotificationsScolaires({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //
    return _NotificationsScolaires();
  }
}

class _NotificationsScolaires extends State<NotificationsScolaires> {
  Timer? timer;
  init() {
    timer = Timer.periodic(const Duration(seconds: 5), (c) {
      print("temps: ${c.tick}");
      controller.next();
      //pageController.nextPage(
      //  duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  //
  PageController pageController = PageController(initialPage: 999);
  //viewportFraction: 1.0, keepPage: false,
  double st = 12;
  double taille = 8;
  double pd = 13;
  //
  List cats = [
    {"nom": "Direct Educ tv", "icon": Icons.live_tv},
    {"nom": "Actu & Mag", "icon": Icons.newspaper_outlined},
    //{"nom": "Clin d'œil", "icon": Icons.remove_red_eye},
    //{"nom": "Site", "icon": Icons.language},
    //{"nom": "DINACOPE", "icon": Icons.people},
    {"nom": "Chat avec un agent", "icon": Icons.chat},
    {"nom": "Dépot plainte", "icon": Icons.policy},
    {"nom": "Demande Docs Scolaires", "icon": Icons.article},
    {"nom": "Resultat Examens d'Etat", "icon": Icons.display_settings},
    {"nom": "Demande service", "icon": Icons.seven_k_rounded},
  ];
  //
  //
  SwiperController controller = SwiperController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    init();
  }

  @override
  void dispose() {
    //
    pageController.dispose();
    //
    timer!.cancel();
    //
    super.dispose();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(
            //   flex: 2,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         //scrollDirection: Axis.horizontal,
            //         children: List.generate(
            //           cats1.length,
            //           (e) {
            //             //
            //             return Expanded(
            //               flex: 3,
            //               child: InkWell(
            //                 onTap: () {
            //                   if (e == 0) {
            //                     Get.to(const DirectEductivi());
            //                   }
            //                   //
            //                   if (e == 1) {
            //                     Get.to(const ClinOeil());
            //                   }
            //                   //
            //                   if (e == 2) {
            //                     Get.to(const Actualites());
            //                   }
            //                   //
            //                   if (e == 3) {
            //                     Get.to(const Dinacope());
            //                   }
            //                   //

            //                   // Navigator.of(context).push(
            //                   //   MaterialPageRoute(
            //                   //     builder: (context) {
            //                   //       return const DirectEductivi();
            //                   //     },
            //                   //   ),
            //                   // );
            //                 },
            //                 //style: ElevatedButton.styleFrom(),
            //                 child: Container(
            //                   width: Get.size.width / 4.2,
            //                   alignment: Alignment.center,
            //                   margin: const EdgeInsets.all(5),
            //                   height: 40,
            //                   decoration: BoxDecoration(
            //                     color: e == 0
            //                         ? Colors.black
            //                         : e == 1
            //                             ? Colors.red.shade700
            //                             : e == 2
            //                                 ? Colors.teal
            //                                 : Colors.pink,
            //                     borderRadius: BorderRadius.circular(15),
            //                   ),
            //                   child: Text(
            //                     cats1[e]['nom'],
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       fontSize: st,
            //                       fontWeight: FontWeight.bold,
            //                       color:
            //                           Colors.white, //e == 0 ? : Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         //scrollDirection: Axis.horizontal,
            //         children: List.generate(
            //           cats2.length,
            //           (e) {
            //             //
            //             return Expanded(
            //               flex: 3,
            //               child: InkWell(
            //                 onTap: () {
            //                   if (e == 0) {
            //                     Get.to(const DirectEductivi());
            //                   }
            //                   //
            //                   if (e == 1) {
            //                     Get.to(const ClinOeil());
            //                   }
            //                   //
            //                   if (e == 2) {
            //                     Get.to(const Actualites());
            //                   }
            //                   //
            //                   if (e == 3) {
            //                     Get.to(const Dinacope());
            //                   }
            //                   //

            //                   // Navigator.of(context).push(
            //                   //   MaterialPageRoute(
            //                   //     builder: (context) {
            //                   //       return const DirectEductivi();
            //                   //     },
            //                   //   ),
            //                   // );
            //                 },
            //                 //style: ElevatedButton.styleFrom(),
            //                 child: Container(
            //                   width: Get.size.width / 4.2,
            //                   alignment: Alignment.center,
            //                   margin: const EdgeInsets.all(5),
            //                   height: 40,
            //                   decoration: BoxDecoration(
            //                     color: e == 0
            //                         ? Colors.black
            //                         : e == 1
            //                             ? Colors.red.shade700
            //                             : e == 2
            //                                 ? Colors.teal
            //                                 : Colors.pink,
            //                     borderRadius: BorderRadius.circular(15),
            //                   ),
            //                   child: Text(
            //                     cats2[e]['nom'],
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       fontSize: st,
            //                       fontWeight: FontWeight.bold,
            //                       color:
            //                           Colors.white, //e == 0 ? : Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  children: List.generate(
                    cats.length,
                    (s) {
                      return InkWell(
                        onTap: () {
                          if (s == 0) {
                            Get.to(const DirectEductivi());
                          }
                          //
                          //
                          if (s == 1) {
                            Get.to(AccueilMag());
                          }
                          //
                          if (s == 2) {}
                          //
                          if (s == 3) {
                            //
                            Get.to(DepotPlainte(
                              titre: "MGP\ndépôt plainte",
                            ));
                          }
                          //
                          if (s == 4) {
                            Get.to(Documents(titre: "Documents"));
                          }
                          //
                          if (s == 5) {
                            Get.to(const ResultatExetat());
                          }
                          //
                          if (s == 6) {
                            Get.to(Ige(
                              appB: true,
                            ));
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  cats[s]['icon'],
                                  size: 35,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                "${cats[s]['nom']}".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 7,
              child: Container(
                  child: FutureBuilder(
                future: loadAnnonces(),
                builder: (c, t) {
                  if (t.hasData) {
                    List list = t.data as List;
                    return Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        debugPrint(
                            "${Connexion.lien}annonce/image?id=${list[index]}");
                        return Image.network(
                          "${Connexion.lien}annonce/image?id=${list[index]}",
                          fit: BoxFit.fill,
                        );
                      },
                      //autoplay: true,
                      duration: 2000,
                      controller: controller,
                      itemCount: list.length,
                      pagination: const SwiperPagination(),
                      control: const SwiperControl(),
                    );
                    //
                  } else if (t.hasError) {
                    return Container();
                  }

                  return Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )),
            ),
            // Expanded(
            //   flex: 3,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     //scrollDirection: Axis.horizontal,
            //     children: List.generate(
            //       cats.length,
            //       (e) {
            //         //
            //         return Expanded(
            //           flex: 3,
            //           child: InkWell(
            //             onTap: () {
            //               if (e == 0) {
            //                 Get.to(DirectEductivi());
            //               }
            //               //
            //               if (e == 1) {
            //                 Get.to(ClinOeil());
            //               }
            //               //
            //               if (e == 2) {
            //                 Get.to(Actualites());
            //               }
            //               //
            //               if (e == 3) {
            //                 Get.to(Dinacope());
            //               }
            //               //

            //               // Navigator.of(context).push(
            //               //   MaterialPageRoute(
            //               //     builder: (context) {
            //               //       return const DirectEductivi();
            //               //     },
            //               //   ),
            //               // );
            //             },
            //             //style: ElevatedButton.styleFrom(),
            //             child: Container(
            //               width: Get.size.width / 4.2,
            //               margin: const EdgeInsets.all(5),
            //               height: 100,
            //               decoration: BoxDecoration(
            //                   color: Colors.grey.shade300,
            //                   borderRadius: BorderRadius.circular(5)),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   Expanded(
            //                     flex: 7,
            //                     child: Container(
            //                       alignment: Alignment.center, //
            //                       decoration: const BoxDecoration(
            //                         //color: Colors.blue,
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(10),
            //                           topRight: Radius.circular(10),
            //                         ),
            //                       ),
            //                       child: Icon(
            //                         cats[e]['icon'],
            //                         size: 70,
            //                         color: Colors.blue,
            //                       ),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 3,
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       decoration: const BoxDecoration(
            //                         borderRadius: BorderRadius.only(
            //                           bottomLeft: Radius.circular(10),
            //                           bottomRight: Radius.circular(10),
            //                         ),
            //                       ),
            //                       child: RichText(
            //                         textAlign: TextAlign.center,
            //                         text: TextSpan(
            //                           text: cats[e]['nom'],
            //                           children: [
            //                             TextSpan(
            //                               text: "",
            //                               style: TextStyle(
            //                                 fontSize: taille,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black,
            //                               ),
            //                             )
            //                           ],
            //                           style: TextStyle(
            //                             fontSize: st,
            //                             fontWeight: FontWeight.bold,
            //                             color: Colors.black,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  //
  Future<List> loadAnnonces() async {
    //
    Requete requete = Requete();
    //
    Response response = await requete.getE("annonce/all");
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return [];
    }
  }
}
