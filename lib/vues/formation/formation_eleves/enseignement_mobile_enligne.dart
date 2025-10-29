import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'formation_education_de_base/formation_education_base.dart';
import 'formation_eleve_maternelle/formation_classe_maternelle.dart';
import 'formation_eleve_secondaire/formation_secondaire.dart';

class FormationMobileEnligne extends StatelessWidget {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  List formationsEls = [
    "FORMATION POUR LES ELEVES DE LA MATERNELLE,Animation - 1719837919056.json",
    "FORMATION POUR LES ELEVES DE L'EDUCATION DE BASE,Animation - 1719829657336.json",
    //"FORMATION POUR LES ENCADREURS DE LA MATERNELLE,Animation - 1719829657336.json",
    "FORMATION POUR LES ELEVES DU SECONDAIRE,Animation - 1719837965657.json",
    //"BIBLIOTHEQUE NUMERIQUE,Animation - 1719829962343.json"
  ];
  //
  List formationsPros = [
    "FORMATION POUR LES ENCADREURES DE LA MATERNELLE,Animation - 1719837919056.json",
    "FORMATION POUR LES ENSEIGNANTS DE L'EDUCATION DE BASE,Animation - 1719829657336.json",
    //"FORMATION POUR LES ENCADREURS DE LA MATERNELLE,Animation - 1719829657336.json",
    "FORMATION POUR LES ENSEIGNANTS DU SECONDAIRE,Animation - 1719837965657.json",
    "BIBLIOTHEQUE NUMERIQUE,Animation - 1719829962343.json"
  ];
  //
  String typeFormation;

  FormationMobileEnligne(this.typeFormation, {Key? key}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORMATION ELEVES"),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.6,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          //crossAxisCount: 2,
          children: List.generate(formationsEls.length, (e) {
            print("assets: ${formationsEls[e].split(',')[1]}");
            print("assets: ${formationsPros[e].split(',')[1]}");
            return InkWell(
              onTap: () {
                if (e == 0) {
                  //MenuSecondaireClasseCours
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FormationClasseMaternelle(typeFormation);
                      },
                    ),
                  );
                }
                if (e == 1) {
                  //
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FormationEducationBase(typeFormation);
                      },
                    ),
                  );
                }
                if (e == 2) {
                  //
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FormationSecondaire(typeFormation);
                      },
                    ),
                  );
                }
              },
              child: Card(
                color: Colors.blue.shade100.withOpacity(0.3),
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
                              "assets/${typeFormation == 'Eleve' ? formationsEls[e].split(',')[1] : formationsPros[e].split(',')[1]}"),
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
                                  text:
                                      "${typeFormation == 'Eleve' ? formationsEls[e].split(',')[0] : formationsPros[e].split(',')[0]}",
                                  style: TextStyle(
                                    fontSize: taille,
                                    fontWeight: FontWeight.normal,
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
        ),
      ),
    );
  }
}
