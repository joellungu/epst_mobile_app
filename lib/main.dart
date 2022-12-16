import 'dart:async';
import 'package:epst_app/splash.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/accueil.dart';
import 'package:epst_app/vues/magasin/magasin_controller.dart';
import 'package:epst_app/vues/plainte/depotplainte_controller.dart';
import 'package:epst_app/vues/reforme/reforme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'vues/identification/identification_controller.dart';
import 'vues/ige/demande_identification/demande_identification_controller.dart';
import 'vues/mutuelle/mutuelle_controller.dart';

List liste_ecoles = [];
RxString annee = "".obs;
RxString ecole = "Ecole".obs;
RxString option = "Option".obs;
RxString ecole1 = "".obs;
RxString ecole2 = "".obs;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await GetStorage.init();
  //
  DepotController depotController = Get.put(DepotController());
  //
  DepotPlainteController depotPlainteController =
      Get.put(DepotPlainteController());
  DemandeIdentificationController demandeIdentificationController =
      Get.put(DemandeIdentificationController());
  Get.put(MagasinController());
  Get.put(IdentificationController());
  Get.put(ReformeController());
  MutuelleController mutuelleController = Get.put(MutuelleController());
  //MagasinController magasinController =
  runApp(
    Epst(
      vue: Splash(),
    ),
  );
  //Timer(const Duration(seconds: 5), () {
  //load();
  //});
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
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: vue,
    );
  }
}
/*

*/