import 'dart:async';
import 'package:epst_app/splash.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/accueil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  DepotController depotController = Get.put(DepotController());
  //
  runApp(
    Epst(
      vue: Splash(),
    ),
  );
  Timer(const Duration(seconds: 5), () {
    load();
  });
  //
}

load() async {
  bool v = true;
  if (v) {
    runApp(
      Epst(
        vue: Accueil(),
      ),
    );
  } else {
    runApp(
      Epst(
        vue: Splash(),
      ),
    );
  }
}

class Epst extends StatelessWidget {
  Epst({Key? key, required this.vue}) : super(key: key);

  late Widget vue;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: vue,
    );
  }
}
