import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail.dart';
import 'identification_controller.dart';

class Identification extends GetView<IdentificationController> {
  //
  Map inspecteur = {};
  Identification(this.inspecteur) {
    controller.getListe(inspecteur["province"], inspecteur["district"]);
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des demandeurs"),
      ),
      body: controller.obx(
        (state) {
          List l = state!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: List.generate(l.length, (index) {
              Map e = l[index];
              return ListTile(
                onTap: () {
                  //
                  Get.to(Details(e));
                  //
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${Connexion.lien}identification/piecejointe/${e['id']}")),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //child: Image.network(
                  //  "${Connexion.lien}identification/piecejointe/${e['id']}"),
                ),
                title: Text("${e['nom']} ${e['postnom']}"),
                subtitle: Text("${e['prenom']}"),
                trailing: const Icon(Icons.arrow_forward),
              );
            }),
          );
        },
        onEmpty: Container(),
        onError: (e) {
          return Container();
        },
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
