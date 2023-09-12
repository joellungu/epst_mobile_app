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
  DetailsSyncType2(this.liste, this.inspecteur) {
    List rls = [];
    var i = 0;
    liste.forEach((element) async {
      if (element['valider'] != "0" || element['valider'] != 0) {
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
    });
    //
    box.write("historique_demande_sernie", rls);
    //
    identificationController.getListeSernie(
        inspecteur['province'], inspecteur['district'], inspecteur['antenne']);
  }
  //

  @override
  Widget build(BuildContext context) {
    // TODO: implement build//
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      height: 35,
      width: double.maxFinite,
      child: Obx(
        () => LinearPercentIndicator(
          width: 300,
          lineHeight: 20.0,
          percent: pr / 100,
          center: Text(
            "$pr %",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
          progressColor: Colors.red.shade900,
        ),
      ),
    );
  }
  //
}
