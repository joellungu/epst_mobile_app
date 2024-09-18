import 'dart:async';

import 'package:epst_app/vues/accueil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'utils/synchronisation.dart';

class Splash extends StatelessWidget {
  //
  Future<int> load() async {
    //
    Synchronisation.synchroEcole();
    Synchronisation.synchroAgens();
    Synchronisation.synchroClasseCours();
    //
    var r = await rootBundle.loadString("assets/ecoles.txt");
    List l1 = r.split('\n');
    int t = 0;
    for (String e in l1) {
      t++;
      liste_ecoles.add({
        "ecole": e.split(',')[1],
        "province": e.split(',')[2],
        "code_ecole": e.split(',')[3]
      });
    }
    //print("cool c'est finit $t");
    var a = await rootBundle.loadString("assets/antenne.txt");
    List la = a.split('\n');
    int x = 0;
    for (String e in la) {
      //print("la valeur: $e");
      //t++;
      if (e.split(';').length > 2) {
        liste_antennes.add({
          "antenne": e.split(';')[1],
          "code": e.split(';')[2],
          "province": e.split(';')[3]
        });
      }
    }
    //
    return 1;
    //
    // liste_ecoles.forEach((element) {
    //   print(element);
    // });
  }

  Splash({Key? key}) : super(key: key) {
    //
  }
  Widget getView() {
    Timer(const Duration(seconds: 4), () {
      Get.off(const Accueil());
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          height: Get.size.height / 2,
          width: Get.size.width,
          child: Image.asset(
            "assets/Logo EPST-APP FINAL 2.png",
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: load(),
        builder: (c, t) {
          if (t.hasData) {
            return getView();
          } else if (t.hasError) {
            return Container(
              color: Colors.red,
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                height: Get.size.height / 2,
                width: Get.size.width,
                child: Image.asset(
                  "assets/Logo EPST-APP FINAL 2.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
