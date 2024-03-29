import 'package:accordion/accordion.dart';
import 'package:epst_app/vues/mutuelle/mutuelle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoriqueDemande extends StatefulWidget {
  const HistoriqueDemande({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoriqueDemande();
  }
}

class _HistoriqueDemande extends State<HistoriqueDemande> {
  //
  MutuelleController mutuelleController = MutuelleController();
  TextEditingController cenome = TextEditingController();
  var box = GetStorage();
  RxList l = RxList();

  //
  @override
  void initState() {
    //
    //mutuelleController.
    //
    super.initState();
    //
    l.value = box.read("historique") ?? [];
    l.value = l.value.reversed.toList();
    print(box.read("historique"));
    //
  }

  //
  Future<Map> getStatus(String id) async {
    return mutuelleController.getStatus(id);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Validation"),
        ),
        body: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          children: List.generate(l.length, (index) {
            Map e = l[index];
            String dd = "${e['jour']}".split('.')[0];
            //
            RxInt show = 0.obs;
            //
            return AccordionSection(
                header: Text(
                  "${e['services']} du $dd",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                content: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "id: ${e['id']}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nom: ${e['nom']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Postnom: ${e['postnom']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prenom: ${e['prenom']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Matricule: ${e['matricule']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Direction: ${e['direction']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Services: ${e['services']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Beneficiaire: ${e['beneficiaire']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Notes: ${e['notes']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    /*
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Valider: ${e['valider']}",
                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),)),
                  */
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Province: ${e['province']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "District: ${e['district']}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getStatus("${e['id']}"),
                        builder: (context, t) {
                          if (t.hasData) {
                            Map v = t.data as Map;
                            print("Valider ou: $v");
                            show.value = v['valider'];
                            //setState((){});
                            return SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  v['valider'] == 1
                                      ? const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Validation MESP: Validé",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )
                                      : v['valider'] == 2
                                          ? Column(
                                              children: [
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation MESP: Refusé",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Raison: ${v['raison']}",
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                )
                                              ],
                                            )
                                          : v['valider'] == 3
                                              ? const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation MESP: Expiré",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                )
                                              : const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Validation MESP: En attente",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: v == 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: TextField(
                                                  controller: cenome,
                                                  decoration: InputDecoration(
                                                    hintText: "Cenome medecin",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (cenome
                                                        .text.isNotEmpty) {
                                                      mutuelleController
                                                          .setSaturer(
                                                              this,
                                                              l.value,
                                                              index,
                                                              "${e['id']}",
                                                              cenome.text);
                                                    }
                                                  },
                                                  child: const Text("Effectué"),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            );
                            //return
                          } else if (t.hasError) {
                            return const Text("...");
                          }

                          return Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ));
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
        ));
  }
}
