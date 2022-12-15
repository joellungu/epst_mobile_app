import 'dart:async';

import 'package:epst_app/vues/accueil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class Splash extends StatelessWidget {
  load() async {
    //
    var r = await rootBundle.loadString("assets/ecoles.txt");
    List l1 = r.split('\n');
    for (String e in l1) {
      print(e.split(',')[1]);
      liste_ecoles.add(e.split(',')[1]);
    }
    print("cool c'est finit");
    //
    Get.off(Accueil());
    //
    // liste_ecoles.forEach((element) {
    //   print(element);
    // });
  }

  Splash() {
    //
    load();
    //
    // Timer(const Duration(seconds: 3), () {
    //   //

    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 5),
        child: Image.asset(
          "assets/WhatsApp Image 2022-11-21 at 12.39.59.jpeg",
          fit: BoxFit.contain,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      /*
      Center(
        child: Container(
          child: Image.asset(
            "assets/EPST APP.png",
            fit: BoxFit.contain,
          ),
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
      */
    );
  }
}
