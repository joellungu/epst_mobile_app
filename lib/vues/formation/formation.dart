import 'package:epst_app/vues/formation/formation_eleves/enseignement_mobile_enligne.dart';
import 'package:epst_app/vues/formation/foad.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'eod/eod.dart';

// ignore: must_be_immutable
class Formation extends StatefulWidget {
  String? titre;
  Formation({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Formation();
  }
}

class _Formation extends State<Formation> {
  @override
  void initState() {
    //
    super.initState();
  }

  double st = 15;
  double taille = 10;
  double pd = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        // crossAxisCount: 2,
        // mainAxisSpacing: 5,
        // crossAxisSpacing: 5,
        // childAspectRatio: 1,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const FOAD();
                  },
                ),
              );
            },
            child: Container(
              height: 200,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
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
                          Lottie.asset('assets/Animation - 1719829962343.json'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "",
                          children: const [
                            TextSpan(
                              text: "FOAD MOBILE",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
          InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const EnseignementEnseignantEnligne();
              //     },
              //   ),
              // );
            },
            child: Container(
              height: 200,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
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
                          Lottie.asset('assets/Animation - 1719829657336.json'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "",
                          children: const [
                            TextSpan(
                              text: "FOAD EN LIGNE",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Eod();
                  },
                ),
              );
            },
            child: Container(
              height: 200,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(pd), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child:
                          Lottie.asset('assets/Animation - 1719829768791.json'),
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
                      )),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "EOD\n",
                          children: const [
                            TextSpan(
                              text: "Enseignement ouverte à distance",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
        ],
      ),
    );
  }
}
