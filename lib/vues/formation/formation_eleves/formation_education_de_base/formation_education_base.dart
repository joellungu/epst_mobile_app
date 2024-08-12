import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'cours_primaire.dart';

class FormationEducationBase extends StatelessWidget {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //
  List lecons = [
    "FRANCAIS",
    "MATH-ARITMETIQUE",
    "HISTOIRE",
    "HYGIENE",
    "RELIGION",
    "VOCABULAIRE",
    "TRADITION AFRICAINE",
    "CULTURE GENERALE"
  ];

  FormationEducationBase({Key? key}) : super(key: key);
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
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.8,
              //crossAxisCount: 2,
              children: List.generate(lecons.length, (e) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CoursPrimaire("${lecons[e]}");
                        },
                      ),
                    );
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
                              child: Lottie.asset(
                                  'assets/Animation - 1719837965657.json'),
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
