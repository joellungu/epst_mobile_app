import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get_storage/get_storage.dart';
import 'cours_primaire.dart';
import 'package:get/get.dart';

class FormationEducationBase extends StatelessWidget {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  // List lecons = [
  //   "FRANCAIS",
  //   "MATH-ARITMETIQUE",
  //   "HISTOIRE",
  //   "HYGIENE",
  //   "RELIGION",
  //   "VOCABULAIRE",
  //   "TRADITION AFRICAINE",
  //   "CULTURE GENERALE"
  // ];
  //
  var box = GetStorage();
  //
  String typeFormation;

  FormationEducationBase(this.typeFormation, {Key? key}) : super(key: key);
  //

  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FORMATION EDUCATION DE BASE"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: List.generate(8, (e) {
              return Tab(
                text: "CLASSE ${e + 1}${e == 0 ? 'er' : 'em'}",
              );
            }),
          ),
        ),
        body: TabBarView(
          children: List.generate(8, (e) {
            //
            List listDeCours = [];
            //
            List courss = box.read("classe_cours") ?? [];
            //
            for (List cs in courss) {
              for (Map ee in cs) {
                int cls = e + 1;
                if (ee['categorie'] == "Education de base".toLowerCase() &&
                    ee['propriete'].toLowerCase() ==
                        typeFormation.toLowerCase() &&
                    ee['classe'] == cls) {
                  listDeCours.add(ee['cours']);
                }
              }
            }
            //
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.8,
              //crossAxisCount: 2,
              children: List.generate(listDeCours.length, (l) {
                //
                return InkWell(
                  onTap: () async {
                    //
                    Get.dialog(
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                    //
                    List classe_cours = box.read("classe_cours") ?? [];
                    //
                    List branches = [];
                    //
                    Set types = {};
                    //
                    for (List ll in classe_cours) {
                      for (Map ee in ll) {
                        int cls = e + 1;
                        if (ee['cours'] == listDeCours[l].toLowerCase() &&
                            ee['categorie'] ==
                                "Education de base".toLowerCase() &&
                            ee['classe'] == cls) {
                          branches.add(ee['banche']);
                          types.add(ee['type']);
                        }
                      }
                    }
                    //
                    Get.back();
                    //
                    Get.to(CoursPrimaire(
                        "${listDeCours[l]}", e + 1, branches, types));
                  },
                  child: Card(
                    child: Container(
                      height: 230,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(pd),
                              // child: Image.asset(
                              //   "assets/LOGO-MINEPST-BON.png",
                              //   color: Colors.blue,
                              //   colorBlendMode: BlendMode.color,
                              // ), //
                              decoration: const BoxDecoration(
                                //color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Lottie.asset(
                                  'assets/Animation - 1719837965657.json'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "",
                                  children: [
                                    TextSpan(
                                      text: "${listDeCours[l]}".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                  style: TextStyle(
                                    fontSize: st,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
