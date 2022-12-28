import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail.dart';
import 'identification_controller.dart';

class Identification extends GetView<IdentificationController> {
  //
  Map inspecteur = {};
  //
  RxString text = "".obs;
  //
  Identification(this.inspecteur) {
    controller.getListe(
        inspecteur["role"], inspecteur["province"], inspecteur["district"]);
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
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                height: 45,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onChanged: (t) {
                    //
                    text.value = t;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: List.generate(l.length, (index) {
                    Map e = l[index];
                    return Obx(
                      () => "${l[index]["nom"]}"
                              .toLowerCase()
                              .contains(text.value.toLowerCase())
                          ? ListTile(
                              onTap: () {
                                //
                                Get.to(Details(
                                    e,
                                    inspecteur["role"] == 7,
                                    "${inspecteur["role"]}",
                                    inspecteur["province"],
                                    inspecteur["district"]));
                                //
                              },
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${Connexion.lien}${inspecteur["role"] == 7 ? 'documentscolaire' : inspecteur["role"] == 13 ? 'transfere' : 'identification'}/piecejointe/${e['id']}")),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                //child: Image.network(
                                //  "${Connexion.lien}identification/piecejointe/${e['id']}"),
                              ),
                              title: Text("${e['nom']} ${e['postnom']}"),
                              subtitle: Text("${e['prenom']}"),
                              trailing: const Icon(Icons.arrow_forward),
                            )
                          : Container(),
                    );
                  }),
                ),
              ),
            ],
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
