import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/identification/detail_sernie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'detail.dart';
import 'details_sync_type_2.dart';
import 'identification_controller.dart';

class IdentificationSernie extends GetView<IdentificationController> {
  //
  Map inspecteur = {};
  //
  var box = GetStorage();
  //
  RxString text = "".obs;
  //
  IdentificationSernie(this.inspecteur, {Key? key}) : super(key: key) {
    controller.getListeSernie(
        inspecteur["province"], inspecteur["district"], inspecteur["antenne"]);
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des élèves identifiés"),
      ),
      body: controller.obx(
        (state) {
          List l = state!;
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(
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
                    prefixIcon: const Icon(Icons.search),
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
                                Get.to(DetailSernie(e, index, inspecteur));
                                //
                              },
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${Connexion.lien}sernie/piecejointe/${e['id']}"),
                                      fit: BoxFit.contain),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
          List ls = box.read("historique_demande_sernie") ?? [];
          if (ls.isNotEmpty) {
            //
            Get.dialog(
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const CircularProgressIndicator(
                    strokeWidth: 7,
                  ),
                ),
              ),
            );

            // ls.forEach((ses) {
            //   //
            //   var s = ses['code'];
            //   Map eue = box.read(s) ?? {};
            //   //
            //   ses["photo"] = eue['photo'];
            //   ses["ext"] = eue['ext'];
            // });
            //
            Get.back();
            //
            Get.dialog(
              Material(
                color: Colors.transparent,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: DetailsSyncType2(ls, inspecteur),
                  ),
                ),
              ),
            );
            //
          } else {
            Get.snackbar("Vide", "La liste est vide");
          }
        },
        child: const Icon(Icons.sync),
      ),
    );
  }
}
