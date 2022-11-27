import 'package:accordion/accordion.dart';
import 'package:epst_app/vues/mutuelle/mutuelle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoriqueDemande extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoriqueDemande();
  }

}

class _HistoriqueDemande extends State<HistoriqueDemande> {

  //
  MutuelleController mutuelleController = MutuelleController();
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
    print(box.read("historique"));
    //
  }
  //
  Future<int> getStatus(String id) async {
    return mutuelleController.getStatus(id) ;
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation"),
      ),
      body: Obx(()=> Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,

        children: List.generate(l.length, (index) {
          Map e = l[index];
          String dd = "${e['jour']}".split('.')[0];
          return AccordionSection(
              header: Text("${e['services']} du $dd",
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              content: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("id: ${e['id']}",textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Nom: ${e['nom']}",
                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Postnom: ${e['postnom']}",
                          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Prenom: ${e['prenom']}",
                          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Matricule: ${e['matricule']}",
                          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Direction: ${e['direction']}",
                          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Services: ${e['services']}",
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Beneficiaire: ${e['beneficiaire']}",
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Notes: ${e['notes']}",
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  /*Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Valider: ${e['valider']}",

                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),)),
                  */
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Province: ${e['province']}",
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("District: ${e['district']}",
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),)),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder(
                    future: getStatus("${e['matricule']}"),
                    builder: (context, t){
                      if(t.hasData){
                        int v = t.data as int;
                        return v == 1 ? Text("Validation MESP: Validé", style: TextStyle(fontSize: 20),) : v == 2 ?
                        Text("Validation MESP: Refusé", style: TextStyle(fontSize: 20),) :
                        Text("Validation MESP: En attente", style: TextStyle(fontSize: 20),);
                      }else if(t.hasError){
                        return Text("...");
                      }

                      return Container(height: 50,width: 50,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),);
                    },
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextField(
                            //controller: recherche_matricule,
                            decoration: InputDecoration(
                              hintText: "Cenome medecin",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
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
                              /*
                              if (recherche_matricule.text.isNotEmpty) {
                                Get.to(MutuelleRecherche(
                                    recherche_matricule.text));
                              }
                              */
                            },
                            child: const Text("Effectué"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                )
              );
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
      ))
    );
  }

}