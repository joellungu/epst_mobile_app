import 'dart:async';

import 'package:flutter/material.dart';
import 'package:epst_app/vues/actualite/site.dart';
import 'package:get/get.dart';
import 'package:epst_app/vues/actualite/clin_oeil.dart';
import 'package:epst_app/vues/actualite/dinacope.dart';
import 'package:epst_app/vues/actualite/direct_eductivi.dart';

class NotificationsScolaires extends StatefulWidget {
  NotificationsScolaires({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //
    return _NotificationsScolaires();
  }
}

class _NotificationsScolaires extends State<NotificationsScolaires> {
  Timer? timer;
  init() {
    // timer = Timer.periodic(const Duration(seconds: 4), (c) {
    //   print("temps: ${c.tick}");
    //   //pageController.nextPage(
    //     //  duration: const Duration(seconds: 1), curve: Curves.linear);
    // });
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
    {"nom": "Educ-NC sur le net", "icon": Icons.language},
    {"nom": "DINACOPE", "icon": Icons.live_tv}
  ];
  //

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
    //timer!.cancel();
    //
    super.dispose();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 5),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView(
                reverse: false,
                padEnds: false,
                controller: pageController,
                children: List.generate(cats.length, (x) {
                  //
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: x % 2 == 0 ? Colors.yellow : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
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
                            Get.to(DirectEductivi());
                          }
                          //
                          if (e == 1) {
                            Get.to(ClinOeil());
                          }
                          //
                          if (e == 2) {
                            Get.to(Actualites());
                          }
                          //
                          if (e == 3) {
                            Get.to(Dinacope());
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
                          margin: const EdgeInsets.all(5),
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  child: Icon(
                                    cats[e]['icon'],
                                    size: 70,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
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
                                      text: cats[e]['nom'],
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
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
