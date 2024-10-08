import 'dart:async';

import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/palmares/liste_palmares.dart';
import 'package:epst_app/vues/ige/palmares/palmares_controller.dart';
import 'package:epst_app/widgets/paiement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../recherche_annee.dart';
import '../recherche_ecole.dart';

class DemandePalmares extends StatefulWidget {
  const DemandePalmares({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemandePalmares();
  }
}

class _DemandePalmares extends State<DemandePalmares> {
  //
  int p = 0;
  int d = 0;
  //
  List listeProvince = [
    "Bas-Uele",
    "Equateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasai",
    "Kasai central",
    "Kasai oriental",
    "Kinshasa",
    "Kongo Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];
  //
  List listeOptions = [
    "LATIN-PHILOSOPHIE,101",
    "MATHEMATIQUE-PHYSIQUE,102",
    "CHIMIE-BIOLOGIE,103",
    "LATIN-GREC,104",
    "LATIN-MATHEMATIQUE,105",
    "SCIENCES,106",
    "PEDAGOGIE GENERALE,201",
    "EDUCATION PHYSIQUE,202",
    "NORMALE,203",
    "PEDAGOGIE MATERNELLE,204",
    "COMMERCIALE ET GESTION,301",
    "SECRETARIAT-ADMINISTRATION,302",
    "SOCIALE,401",
    "ARTS PLASTIQUES,501",
    "ARTS DRAMATIQUES,502",
    "MUSIQUE,503",
    "ESTHETIQUE & COIFFURE,504",
    "COIFFURE,505",
    "COUPE-COUTURE,601",
    "HOTESSE D'ACCUEIL,701",
    "HOTELLERIE & RESTAURATION,702",
    "TOURISME,704",
    "AGRICULTURE GENERALE,801",
    "PECHE ET NAVIGATION,802",
    "VETERINAIRE,803",
    "INDUSTRIES AGRICOLES,804",
    "NUTRITION,805",
    "FORESTERIE,806",
    "MECANIQUE GENERALE,901",
    "MECANIQUE MACHINES-OUTILS,902",
    "ELECTRICITE,903",
    "CONSTRUCTION,904",
    "CHIMIE INDUSTRIELLE,905",
    "ELECTRONIQUE,906",
    "IMPRIMERIE,907",
    "COMMUTATION,908",
    "RADIO-TRANSMISSION,909",
    "METEOROLOGIE,910",
    "AVIATION CIVILE,911",
    "PETRO-CHIMIE,914",
    "MECANIQUE AUTOMOBILE,915",
    "CONSTRUCTION METALLIQUE,916",
    "MENUISERIE EBENISTERIE,917",
    "MINE ET GEOLOGIE,918",
    "METALLURGIE,919",
    "DESSIN DE BATIMENT,920",
    "INSTALLATION SANITAIRE,921",
    "TOLERIE,922",
    "AJUSTAGE ET SOUDURE,923",
  ];
  //
  int option = 0;
  //

  int ti = 0;
  int a = 1900;
  //
  RxBool demande = true.obs;
  //
  List liste_annee = [];
  //
  WebViewController? controlleur;

  @override
  void initState() {
    //
    for (int i = 0; i < 500; i++) {
      liste_annee.add(a);
      a++;
    }
    //
    Timer(const Duration(seconds: 3), () {
      loadPayment.value = true;
    });
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande palmares"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ecole",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                showSearch(context: context, delegate: RechercheEcole());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  alignment: Alignment.center,
                  //width: Get.size.width,
                  child: Obx(
                    () => Text(
                      "${ecole.value["ecole"] ?? ''} / ${ecole.value["province"] ?? ''}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ///////////
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Options",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "  ",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: option,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          option = value as int;
                          print("le id: $option");
                        },
                        items: List.generate(
                          listeOptions.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(
                                "${listeOptions[index]}".split(",")[0],
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Année-scolaire",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                showSearch(context: context, delegate: RechercheAnnee());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  alignment: Alignment.center,
                  //width: Get.size.width,
                  child: Obx(
                    () => Text(
                      annee.value,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ///////////
          const SizedBox(
            height: 10,
          ),
          /*
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Options",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "  Option:",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<int>(
                              value: option,
                              /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                              isExpanded: true,
                              onChanged: (value) {
                                option = value as int;
                                print("le id: $option");
                                print("${listeOptions[option]}".split(",")[1]);
                              },
                              items: List.generate(
                                listeOptions.length,
                                (index) {
                                  return DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      "${listeOptions[index]}".split(",")[0],
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                */
          ///
          ElevatedButton(
            onPressed: () async {
              String v = ecole["code_ecole"]; //.replaceAll(RegExp(r"\s+"), "");
              String n = ecole["ecole"]; //.replaceAll(RegExp(r"\s+"), "");
              String p = ecole["province"]; //.replaceAll(RegExp(r"\s+"), "");
              print(v[11]);
              print(v.length);
              print(v.runtimeType);

              showDialog(
                context: context,
                builder: (c) {
                  return Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 300,
                        width: 270,
                        child: PayementMethode({
                          "nomecole": n,
                          "option":
                              "${"${listeOptions[option]}".split(",")[0]}.0",
                          "nomprovince": p,
                          "codeecole": v,
                          "codeoption": "${listeOptions[option]}".split(",")[1],
                          "anneescolaire": annee.value,
                        }, 0.6, send, "palmares", "palmares"),
                      ), //0.02
                    ),
                  );
                },
              );
              //*/
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text("Demander"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Formulaire payant (0.50 dollar)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              //
              Get.to(ListPalmares());
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text("Voir palmares demandé"),
            ),
          ),
          /*
                Obx(
                  () => loadPayment.value
                      ? SizedBox(
                          height: Get.size.height / 2,
                          child: Palmares(),
                        )
                      : Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 5,
                            width: 100,
                            child: LinearProgressIndicator(),
                          ),
                        ),
                )
              */
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controlleur!.reload();
      //   },
      //   child: Icon(Icons.sync),
      // ),
    );
  }

  send(Map e) async {
    //Get.back();
    print(e['codeecole'].runtimeType);
    PalmaresController palmaresController = Get.find(); //
    palmaresController.getListe(e['nomprovince'], e['nomecole'], e['option'],
        e['codeecole'], e['codeoption'], e['anneescolaire']);
    /*
    @,
     ,
    */
  }
}
