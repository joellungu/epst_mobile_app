import 'package:epst_app/vues/ige/sernie/sernie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailsSyncType1 extends StatelessWidget {
  List liste;
  //
  var box = GetStorage();
  //
  State state;
  //
  SernieController sernieController = Get.find();
  //
  String percentage = "";
  RxDouble pr = 0.00001.obs;
  int sent = 0;
  //
  Future<bool> load(List rls) async {
    for (var element in liste) {
      bool v = false;
      try {
        v = await sernieController.saveCommande(element);
        //
        if (v) {
          sent++;
          print("sent: $sent");
          percentage = (sent / liste.length * 100).toStringAsFixed(2);
          print("percentage: $percentage");
          pr.value = double.parse(percentage);
          print("pr: $pr");
        } else {
          print("garde l'ancienne liste: $rls");
          rls.add(element);
        }
      } catch (e) {
        //
        rls.add(element);
      }
    }
    return true;
  }

  //
  load2() async {
    List rls = [];
    bool v = await load(rls);
    if (v) {
      box.write("historique_sernie", rls);
      print("rls: $rls");
      //
      // ignore: invalid_use_of_protected_member
      state.setState(() {});
      //
    }
  }

  //
  DetailsSyncType1(this.liste, this.state) {
    //List rls = [];
    //var i = 0;
    load2();
    //
  }
  //

  @override
  Widget build(BuildContext context) {
    //
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
