import 'package:epst_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'demande_identification.dart';
import 'historique_demande_identification.dart';

class Identification extends StatefulWidget {
  String? titre;
  //
  Identification({Key? key, this.titre}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _Identification();
  }
}

class _Identification extends State<Identification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titre}"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 7,
        childAspectRatio: 0.8,
        children: [
          ElevatedButton(
            onPressed: () {
              //
              Get.to(DemandeIdentification(titre: "Demande d'identification"));
            },
            // style: const ButtonStyle(
            //     /*
            //   backgroundColor: MaterialStateProperty.all(
            //     Colors.blue.shade400,
            //   ),
            //   */
            //     ),
            // child: Container(
            //   padding: const EdgeInsets.all(10),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Expanded(
            //         flex: 7,
            //         child: Container(
            //           alignment: Alignment.center, //
            //           decoration: const BoxDecoration(
            //               //color: Colors.blue,
            //               borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10),
            //           )),
            //           child: Image.asset(
            //             "assets/LOGO-MINEPST-BON.png",
            //             color: Colors.blue,
            //             colorBlendMode: BlendMode.color,
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 3,
            //         child: Container(
            //           alignment: Alignment.center,
            //           decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(10),
            //             bottomRight: Radius.circular(10),
            //           )),
            //           child: RichText(
            //             textAlign: TextAlign.center,
            //             text: const TextSpan(
            //               text: "Demande d'identification",
            //               children: [
            //                 TextSpan(
            //                   text: "",
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.normal,
            //                     color: Colors.black,
            //                   ),
            //                 )
            //               ],
            //               style: TextStyle(
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.normal,
            //                 color: Colors.black,
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              backgroundColor: Utils.couleursCards(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: ExactAssetImage(
                              "assets/LOGO-MINEPST-BON.png",
                            ),
                          ),
                          borderRadius: BorderRadius.circular(25),
                          //color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Text(
                        "Demande d'identification",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(const HistoriqueDemandeIdentification());
            },
            // style: const ButtonStyle(
            //     /*
            //   backgroundColor: MaterialStateProperty.all(
            //     Colors.blue.shade400,
            //   ),
            //   */
            //     ),
            // child: Container(
            //   padding: const EdgeInsets.all(10),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Expanded(
            //         flex: 7,
            //         child: Container(
            //           alignment: Alignment.center, //
            //           decoration: const BoxDecoration(
            //               //color: Colors.blue,
            //               borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10),
            //           )),
            //           child: Image.asset(
            //             "assets/LOGO-MINEPST-BON.png",
            //             color: Colors.blue,
            //             colorBlendMode: BlendMode.color,
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 3,
            //         child: Container(
            //           alignment: Alignment.center,
            //           decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(10),
            //             bottomRight: Radius.circular(10),
            //           )),
            //           child: RichText(
            //             textAlign: TextAlign.center,
            //             text: const TextSpan(
            //               text: "Validation",
            //               children: [
            //                 TextSpan(
            //                   text: "",
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.normal,
            //                     color: Colors.black,
            //                   ),
            //                 )
            //               ],
            //               style: TextStyle(
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.normal,
            //                 color: Colors.black,
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              backgroundColor: Utils.couleursCards(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: ExactAssetImage(
                              "assets/LOGO-MINEPST-BON.png",
                            ),
                          ),
                          borderRadius: BorderRadius.circular(25),
                          //color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Text(
                        "Validation",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
