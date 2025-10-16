import 'package:epst_app/vues/formation/cursus/profile_apprenant/profile_apprenant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import for Android features.
// Import for iOS features.

import 'cursus/cursus.dart';
import 'formation_eleves/enseignement_mobile_enligne.dart';
import 'formation_en_ligne/login.dart';
// #enddocregion platform_imports

class FOAD extends StatefulWidget {
  const FOAD({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FOAD();
  }
}

class _FOAD extends State<FOAD> {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  RxInt current_index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOAD MOBILE"),
      ),
      body: Obx(
        () => current_index.value == 0
            //?
            //Cursus()
            //:
            //current_index.value == 1
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.6,
                padding: const EdgeInsets.all(5),
                //crossAxisCount: 2,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(FormationMobileEnligne("Professeur"));
                    },
                    child: Card(
                      child: Container(
                        height: 220,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(pd),
                                // child: Image.asset(
                                //   "assets/LOGO-MINEPST-BON.png",
                                //   color: Colors.blue,
                                //   colorBlendMode: BlendMode.color,
                                // ), //
                                decoration: const BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Lottie.asset(
                                    'assets/Animation - 1719837917526.json'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
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
                                    text: "",
                                    children: [
                                      TextSpan(
                                        text:
                                            "COMMENCER\nFORMATION PROFESSEURS",
                                        style: TextStyle(
                                          fontSize: taille,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(FormationMobileEnligne("Eleve"));
                    },
                    child: Card(
                      child: Container(
                        height: 220,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(pd),
                                // child: Image.asset(
                                //   "assets/LOGO-MINEPST-BON.png",
                                //   color: Colors.blue,
                                //   colorBlendMode: BlendMode.color,
                                // ), //
                                decoration: const BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Lottie.asset(
                                    'assets/Animation - 1719838060757.json'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
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
                                    text: "",
                                    children: [
                                      TextSpan(
                                        text:
                                            "COMMENCER\nFORMATION ELEVES (MA CLASSE)",
                                        style: TextStyle(
                                          fontSize: taille,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Get.to(Cursus());
                    },
                    child: Card(
                      child: Container(
                        height: 220,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(pd),
                                // child: Image.asset(
                                //   "assets/LOGO-MINEPST-BON.png",
                                //   color: Colors.blue,
                                //   colorBlendMode: BlendMode.color,
                                // ), //
                                decoration: const BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Lottie.asset(
                                    'assets/Animation - 1719837910139.json'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
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
                                    text: "",
                                    children: [
                                      TextSpan(
                                        text: "COMMENCER\nLA CERTIFICATION",
                                        style: TextStyle(
                                          fontSize: taille,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(Login());
                    },
                    child: Card(
                      child: Container(
                        height: 220,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(pd),
                                // child: Image.asset(
                                //   "assets/LOGO-MINEPST-BON.png",
                                //   color: Colors.blue,
                                //   colorBlendMode: BlendMode.color,
                                // ), //
                                decoration: const BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Lottie.asset(
                                    'assets/Animation - 1719837965657.json'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
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
                                    text: "",
                                    children: [
                                      TextSpan(
                                        text:
                                            "PROFESSEUR EN LIGNE\n(ENSEIGNEMENT A DISTANCE)",
                                        style: TextStyle(
                                          fontSize: taille,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const ProfileApprenant(),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: current_index.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
          onTap: (e) {
            //
            print(e);
            current_index.value = e;
          },
          items: const [
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.school_outlined), label: "Cursus Elève"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: "Cursus"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
