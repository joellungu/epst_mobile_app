import 'dart:async';

import 'package:epst_app/vues/accueil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class Splash extends StatelessWidget {
  //
  Future<int> load() async {
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
    //
    return 1;
    //
    // liste_ecoles.forEach((element) {
    //   print(element);
    // });
  }

  Splash() {
    //
  }
  Widget getView() {
    Timer(const Duration(seconds: 4), () {
      Get.off(Accueil());
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Image.asset(
            "assets/EPST APP.png",
            fit: BoxFit.contain,
          ),
          height: Get.size.height / 2,
          width: Get.size.width,
        ),
        SizedBox(
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
                child: Image.asset(
                  "assets/EPST APP.png",
                  fit: BoxFit.contain,
                ),
                height: Get.size.height / 2,
                width: Get.size.width,
              ),
            ],
          );
        },
      ),
    );
  }
}
