import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'primaire/menu_primaire_classe_cours.dart';

class FormationEnseignantMobile extends StatelessWidget {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  List formations = [
    "FORMATION POUR LES ENCADREURS DE LA MATERNELLE,Animation - 1719838039108.json",
    "FORMATION POUR LES ENSEIGNANTS DE L'EDUCATION DE BASE,Animation - 1719837919056.json",
    "FORMATION POUR LES ENSEIGNANTS DU SECONDAIRE,Animation - 1719837965657.json"
  ];
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORMATION PROFESSEURS"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: List.generate(formations.length, (e) {
          print("assets: ${formations[e].split(',')[1]}");
          return InkWell(
            onTap: () {
              if (e == 1) {
                //
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MenuPrimaireClasseCours();
                    },
                  ),
                );
              }
            },
            child: Container(
              height: 230,
              margin: EdgeInsets.only(top: 10),
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
                      child:
                          Lottie.asset('assets/${formations[e].split(',')[1]}'),
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
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "",
                          children: [
                            TextSpan(
                              text: "${formations[e].split(',')[0]}",
                              style: TextStyle(
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
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
}
