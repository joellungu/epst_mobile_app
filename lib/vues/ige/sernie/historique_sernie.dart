import 'package:accordion/accordion.dart';
import 'package:epst_app/vues/identification/identification_controller.dart';
import 'package:epst_app/vues/mutuelle/mutuelle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'details_eleve.dart';
import 'details_sync_type_1.dart';

class HistoriqueSernie extends StatefulWidget {
  const HistoriqueSernie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoriqueSernie();
  }
}

class _HistoriqueSernie extends State<HistoriqueSernie> {
  //
  MutuelleController mutuelleController = Get.find();
  IdentificationController identificationController = Get.find();
  TextEditingController cenome = TextEditingController();
  var box = GetStorage();
  RxList l = RxList();
  //
  RxString text = "".obs;
  //
  @override
  void initState() {
    //
    //mutuelleController.
    //
    super.initState();
    //
    l.value = box.read("historique_sernie") ?? [];
    l.value = l.value.reversed.toList();
    //print(box.read("historique_sernie"));
    //
  }

  //
  Future<Map> getStatus(String id) async {
    return identificationController.getStatus(id, true);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
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
            child: Obx(
              () => ListView(
                children: List.generate(l.length, (index) {
                  Map e = l[index];
                  String dd = "${e['jour']}".split('.')[0];
                  //
                  print(e);
                  //
                  RxInt show = 0.obs;
                  //DetailEleve()
                  return "${l[index]["nom"]} ${l[index]["postnom"]} ${l[index]["prenom"]}"
                          .toLowerCase()
                          .contains(text.value.toLowerCase())
                      ? ListTile(
                          title: Text(
                              "${l[index]["nom"]} ${l[index]["postnom"]} ${l[index]["prenom"]}"),
                          subtitle: Text(
                              "${l[index]["nom"]} ${l[index]["postnom"]} ${l[index]["prenom"]}"),
                          onTap: () {
                            Get.to(
                              DetailEleve(e, index),
                            );
                          },
                        )
                      : Container();
                  /*
          return ListTile(
            leading: Icon(Icons.file_present_rounded),
            title: Text("${e['services']}"),
            //${e['nom']} ${e['postnom']} ${e['prenom']}
            subtitle: Text("${e['matricule']} ${e['direction']} / ${e['jour'] ?? ''}"),
            trailing: FutureBuilder(
              future: getStatus("${e['matricule']}"),
              builder: (context, t){
                if(t.hasData){
                  int v = t.data as int;
                  return v == 1 ? Text("Validé") : v == 2 ? Text("Refusé") : Text("En attente");
                }else if(t.hasError){
                  return Text("...");
                }

                return Container(height: 50,width: 50,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),);
              },
            ),
          );
          */
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
          List ls = box.read("historique_sernie") ?? [];
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

            ls.forEach((ses) {
              //
              var s = ses['code'];
              Map eue = box.read(s) ?? {};
              //
              ses["photo"] = eue['photo'];
              ses["ext"] = eue['ext'];
            });
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
                    child: DetailsSyncType1(ls, this),
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
//
}
