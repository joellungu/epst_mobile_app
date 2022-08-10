import 'dart:async';

import 'package:epst_app/vues/accueil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  Splash() {
    Timer(Duration(seconds: 5), () {
      //
      Get.off(Accueil());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/EPST APP.png",
            fit: BoxFit.contain,
          ),
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }
}
