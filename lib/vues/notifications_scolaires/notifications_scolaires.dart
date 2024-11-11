import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
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
    timer = Timer.periodic(const Duration(seconds: 10), (c) {
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
    {"nom": "Direct", "icon": Icons.live_tv},
    {"nom": "Clin d'œil", "icon": Icons.remove_red_eye},
    {"nom": "Site officiel", "icon": Icons.language},
    {"nom": "DINACOPE", "icon": Icons.live_tv}
  ];
  //
  List listAccueil = [
    {"nom": "IMG-20240829-WA0198.jpg"},
    {"nom": "IMG-20240803-WA0025.jpg"},
    {"nom": "ROLL UP_Plan de travail.jpg"},
    {"nom": "ROLL UP_Plan de travail 1 copie.jpg"},
  ];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //scrollDirection: Axis.horizontal,
              children: List.generate(
                cats.length,
                (e) {
                  //
                  return Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        if (e == 0) {
                          Get.to(const DirectEductivi());
                        }
                        //
                        if (e == 1) {
                          Get.to(const ClinOeil());
                        }
                        //
                        if (e == 2) {
                          Get.to(const Actualites());
                        }
                        //
                        if (e == 3) {
                          Get.to(const Dinacope());
                        }
                        //

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const DirectEductivi();
                        //     },
                        //   ),
                        // );
                      },
                      //style: ElevatedButton.styleFrom(),
                      child: Container(
                        width: Get.size.width / 4.2,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                          color: e == 0
                              ? Colors.black
                              : e == 1
                                  ? Colors.red.shade700
                                  : e == 2
                                      ? Colors.teal
                                      : Colors.pink,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          cats[e]['nom'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: st,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, //e == 0 ? : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              flex: 9,
              child: Container(
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      "assets/${listAccueil[index]['nom']}",
                      fit: BoxFit.fill,
                    );
                  },
                  //autoplay: true,
                  duration: 2000,
                  controller: controller,
                  itemCount: listAccueil.length,
                  pagination: const SwiperPagination(),
                  control: const SwiperControl(),
                ),
              ),
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
}
