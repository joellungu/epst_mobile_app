import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'type_cours.dart';
import 'package:get/get.dart';
import 'lecon.dart';
import 'package:epst_app/utils/requetes.dart';

class CoursMaternelle extends StatelessWidget {
  //
  Requete requete = Requete();
  //
  String cours;
  //
  int classe;
  //
  CoursMaternelle(this.cours, this.classe, {Key? key}) : super(key: key) {
    //
    print("Classe: $classe");
    //
  }
  //
  List lecons = [
    "CONJUGAISON",
    "VOCABULAIRE",
    "ORTHOGRAPHE",
    "GRAMMAIRE",
    "LECTURE",
    "Painture",
  ];
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(cours),
        centerTitle: true,
      ),
      body: GridView.count(
        //Maternelle
        //Primaire
        //Education de base
        //Secondaire
        //
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        children: List.generate(lecons.length, (e) {
          return InkWell(
            onTap: () {
              //
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    //
                    return Container(
                      child: FutureBuilder(
                        future:
                            getNotion(cours, "Maternelle", lecons[e], classe),
                        builder: (c, t) {
                          //
                          if (t.hasData) {
                            //
                            List cs = t.data as List;
                            //
                            return ListView(
                              padding: const EdgeInsets.all(10),
                              children: List.generate(cs.length, (c) {
                                return ListTile(
                                  onTap: () {
                                    //
                                    Get.to(
                                      TypeCours(
                                        cours,
                                        "Maternelle".toLowerCase(),
                                        lecons[e],
                                        "${cs[c]['notion']}",
                                        classe,
                                      ),
                                    );
                                    //
                                  },
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.book),
                                  ),
                                  title: Text("${cs[c]['notion']}"),
                                );
                              }),
                            );
                            //
                          } else if (t.hasError) {
                            return Container();
                          }

                          return Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    );
                  });
              //
            },
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
                      child:
                          Lottie.asset('assets/Animation - 1719837965657.json'),
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
                              text: "${lecons[e]}",
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
          );
        }),
      ),
    );
  }

  //
  Future<List> getNotion(
      String cours, String categorie, String banche, int classe) async {
    //
    categorie = categorie.toLowerCase();
    //
    cours = cours.toLowerCase();
    //
    Response response = await requete.getE(
        "cours/notion?cours=$cours&categorie=$categorie&banche=$banche&classe=$classe");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return [];
    }
  }
}
