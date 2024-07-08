import 'package:epst_app/vues/identification/identification_controller.dart';
import 'package:epst_app/vues/ige/sernie/sernie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailsSyncType2 extends StatelessWidget {
  List liste;
  //
  var box = GetStorage();
  Map inspecteur;

  //
  SernieController sernieController = Get.find();
  IdentificationController identificationController = Get.find();
  //
  String percentage = "";
  RxDouble pr = 0.00001.obs;
  int sent = 0;
  //
  Future<bool> load(List rls) async {
    for (var element in liste) {
      //
      print("Validé: ${element['valider'].runtimeType}");
      //
      if (element['valider'] != 0) {
        bool v = await sernieController.updateCommande(element);
        if (v) {
          sent++;
          print("sent: $sent");
          percentage = (sent / liste.length * 100).toStringAsFixed(2);
          print("percentage: $percentage");
          pr.value = double.parse(percentage);
          print("pr: $pr");
        } else {
          rls.add(element);
        }
      } else {
        rls.add(element);
      }
    }
    return true;
  }

  load2() async {
    List rls = [];
    bool v = await load(rls);
    if (v) {
      box.write("historique_demande_sernie", rls);
      print("rls: $rls");
      //
      identificationController.getListeSernie(inspecteur['province'],
          inspecteur['district'], inspecteur['antenne']);
    }
  }

  //
  DetailsSyncType2(this.liste, this.inspecteur, {Key? key}) : super(key: key) {
    //var i = 0;
    load2();
    //
    // liste.forEach((element) async {
    //   //
    //   print("Validé: ${element['valider'].runtimeType}");
    //   //
    //   if (element['valider'] != 0) {
    //     bool v = await sernieController.updateCommande(element);
    //     if (v) {
    //       sent++;
    //       print("sent: $sent");
    //       percentage = (sent / liste.length * 100).toStringAsFixed(2);
    //       print("percentage: $percentage");
    //       pr.value = double.parse(percentage);
    //       print("pr: $pr");
    //     } else {
    //       rls.add(element);
    //     }
    //   } else {
    //     rls.add(element);
    //   }
    // });
    //historique_demande_sernie
    //historique_demande_sernie ::
  }
  //

  @override
  Widget build(BuildContext context) {
    // TODO: implement build//
    return Center(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          height: 35,
          width: 320,
          child: Obx(
            () => LinearPercentIndicator(
              width: 300,
              lineHeight: 20.0,
              percent: pr / 100,
              center: Text(
                "$pr %",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
              progressColor: Colors.red.shade900,
            ),
          ),
        ),
      ),
    );
  }
  //
}
