import 'package:epst_app/vues/formation/formation_enseignants/primaire/type_cours.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'lecon.dart';

class CoursPrimaire extends StatelessWidget {
  //
  String cours;
  //
  CoursPrimaire(this.cours, {Key? key}) : super(key: key);
  //
  List lecons = [
    "CONJUGAISON",
    "VOCABULAIRE",
    "ORTHOGRAPHE",
    "GRAMMAIRE",
    "LECTURE",
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
        //
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        children: List.generate(lecons.length, (e) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TypeCours("${lecons[e]}");
                  },
                ),
              );
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
}
