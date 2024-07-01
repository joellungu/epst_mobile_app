import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'formation_enseignants/formation_enseignant_mobile.dart';
// #enddocregion platform_imports

class FOAD extends StatefulWidget {
  const FOAD({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FOAD();
  }
}

class _FOAD extends State<FOAD> {
  //
  double st = 15;
  double taille = 10;
  double pd = 15;
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOAD MOBILE"),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
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
                      return FormationEnseignantMobile();
                    },
                  ),
                );
              },
              child: Container(
                height: 220,
                margin: EdgeInsets.only(top: 0),
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
                            'assets/Animation - 1719837917526.json'),
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
                            children: const [
                              TextSpan(
                                text: "COMMENCER\nFORMATION PROFESSEURS",
                                style: TextStyle(
                                  fontSize: 18,
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
                height: 220,
                margin: EdgeInsets.only(top: 0),
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
                            'assets/Animation - 1719838060757.json'),
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
                            children: const [
                              TextSpan(
                                text: "COMMENCER\nFORMATION ELEVES",
                                style: TextStyle(
                                  fontSize: 18,
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
                height: 220,
                margin: EdgeInsets.only(top: 0),
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
                            'assets/Animation - 1719837910139.json'),
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
                            children: const [
                              TextSpan(
                                text: "COMMENCER\nLA CERTIFICATION",
                                style: TextStyle(
                                  fontSize: 18,
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
          ],
        ),
      ),
    );
  }
}
