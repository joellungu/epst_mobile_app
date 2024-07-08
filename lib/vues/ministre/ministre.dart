import 'package:accordion/accordion.dart';
import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/recherche_annee.dart';
import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/sernie_stat/nombre_eleve.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ministre extends GetView<MinistreController> {
  List l = [
    {
      "titre": "Nombre d'élève",
      "stat": [
        {"nom": "Nombre d'élèves"},
        {"nom": "Nombre d'élèves par province"},
        {"nom": "Parité"},
      ],
    },
    {
      "titre": "Nombre d'ecole",
      "stat": [],
    },
    //{"titre": "Statistique personel (DRH)"},
    //{"titre": "Statistique enseignant (Dinacope)"},
    {
      "titre": "Statistique IGE",
      "stat": [],
    },
    {
      "titre": "Statistique mutuelle",
      "stat": [],
    },
    //{"titre": "Statistique financier IGE"},
    //{"titre": "Statistique "},
    //{"titre": ""},
  ];

  Ministre({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tableau de bord de l'EPST"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/LOGO-MINEPST-BON.png",
              height: 200,
              width: 200,
              //color: Colors.white,
              //colorBlendMode: BlendMode.color,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 1,
              child: Accordion(
                maxOpenSections: 2,
                headerBackgroundColorOpened: Colors.black,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                children: List.generate(l.length, (index) {
                  Map e = l[index];
                  //String dd = "${e['jour']}".split('.')[0];
                  //
                  print(e);
                  //
                  RxInt show = 0.obs;
                  //
                  return AccordionSection(
                    header: Text(
                      "${e['titre']}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Column(
                      children: [
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: InkWell(
                            onTap: () {
                              //
                              showSearch(
                                  context: context, delegate: RechercheAnnee());
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                //width: Get.size.width,
                                child: Obx(
                                  () => Text(
                                    annee.value.isEmpty
                                        ? "Année-scolaire"
                                        : annee.value,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(e['stat'].length, (i) {
                            Map x = e['stat'][i];
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  //
                                  Get.to(const NombreEleve());
                                  //
                                },
                                child: Text("${x['nom']}"),
                              ),
                            );
                          }),
                        ),
                        /*
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nom: ${e['nom']}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        */
                      ],
                    ),
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
              ),
            )
          ],
        ));
  }
}
