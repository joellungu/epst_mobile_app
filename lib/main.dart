import 'package:epst_app/splash.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/accueil.dart';
import 'package:epst_app/vues/ige/documents_certificatifs/document_certificatif_controller.dart';
import 'package:epst_app/vues/magasin/magasin_controller.dart';
import 'package:epst_app/vues/plainte/depotplainte_controller.dart';
import 'package:epst_app/vues/reforme/reforme_controller.dart';
import 'package:epst_app/vues/sg/sg_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'vues/identification/identification_controller.dart';
import 'vues/ige/demande_identification/demande_identification_controller.dart';
import 'vues/ige/demande_transfere/transfere_controller.dart';
import 'vues/ige/palmares/palmares_controller.dart';
import 'vues/ige/resultat_exetat/resultat_controller.dart';
import 'vues/ige/sernie/sernie_controller.dart';
import 'vues/mutuelle/mutuelle_controller.dart';
import 'widgets/paiement_controller.dart';

//
List liste_ecoles = [];
List liste_antennes = [];
RxString annee = "".obs;
RxMap ecole = {"ecole": "", "province": ""}.obs;
//
RxMap antenne = {"antenne": "", "province": ""}.obs;
RxMap code_antenne = {"ecole": "", "province": ""}.obs;
//
RxString option = "Option".obs;
RxMap ecole1 = {"ecole": "", "province": ""}.obs;
RxMap ecole2 = {"ecole": "", "province": ""}.obs;
RxBool loadPayment = false.obs;
RxMap infoPayment = {}.obs;
//

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await GetStorage.init();
  //
  DepotController depotController = Get.put(DepotController());
  //
  SgController sgController = Get.put(SgController());
  //
  DepotPlainteController depotPlainteController =
      Get.put(DepotPlainteController());
  DemandeIdentificationController demandeIdentificationController =
      Get.put(DemandeIdentificationController());
  Get.put(PaiementController());
  Get.put(MagasinController());
  Get.put(IdentificationController());
  Get.put(PalmaresController());
  Get.put(ReformeController());
  Get.put(DemandeDocumentController());
  Get.put(TransfereController());
  Get.put(ResultatController());
  MutuelleController mutuelleController = Get.put(MutuelleController());
  SernieController sernieController = Get.put(SernieController());
  //
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
        vue: const Accueil(),
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
      /*
      home: UpgradeAlert(
        child: vue,
      ),
      */
    );
  }
}
/*

*/