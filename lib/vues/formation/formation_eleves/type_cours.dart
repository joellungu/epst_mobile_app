import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'lecon_pdf.dart';
import 'package:get/get.dart';
import 'lecon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class TypeCours extends StatelessWidget {
  //
  String cours;
  //
  String categorie;
  //
  String banche;
  //
  String notion;
  //
  String type;
  //
  String typeFormation;
  //
  int classe;
  //

  //
  List types = [
    "INTERACTIF",
    "PDF",
    "VIDEO",
  ];
  //
  TypeCours(this.cours, this.categorie, this.banche, this.notion, this.classe,
      this.type, this.typeFormation,
      {Key? key})
      : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(banche),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: List.generate(types.length, (e) {
                return InkWell(
                  onTap: () async {
                    //
                    bool connec = false;
                    //
                    final List<ConnectivityResult> connectivityResult =
                        await (Connectivity().checkConnectivity());

                    if (connectivityResult
                            .contains(ConnectivityResult.mobile) ||
                        connectivityResult.contains(ConnectivityResult.wifi) ||
                        connectivityResult
                            .contains(ConnectivityResult.ethernet) ||
                        connectivityResult
                            .contains(ConnectivityResult.bluetooth)) {
                      connec = true;
                    } else {
                      connec = false;
                    }
                    if (e == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Lecon("${types[e]}");
                          },
                        ),
                      );
                    }
                    //
                    if (e == 1 && type.toLowerCase().contains("pdf")) {
                      Get.to(
                        LeconPdf(cours, categorie, banche, "pdf", notion,
                            classe, connec, typeFormation),
                      );
                    }
                    //
                    if (e == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Lecon("${types[e]}");
                          },
                        ),
                      );
                    }
                    //
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
