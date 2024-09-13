import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'lecon.dart';

class TypeCours extends StatelessWidget {
  //
  String type;
  //
  List types = [
    "INTERACTIF",
    "PDF",
    "VIDEO",
  ];
  //
  TypeCours(this.type, {Key? key}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(type),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: List.generate(types.length, (e) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LeconMat("${types[e]}");
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 220,
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
                            padding: const EdgeInsets.all(15),
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
                                    text: "${types[e]}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                                style: TextStyle(
                                  fontSize: 15,
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
          ],
        ),
      ),
    );
  }
}
