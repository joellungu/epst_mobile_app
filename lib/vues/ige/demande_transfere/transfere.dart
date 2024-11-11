import 'package:epst_app/utils/utils.dart';
import 'package:epst_app/vues/ige/demande_transfere/demande_transfere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'historique_transfere.dart';

class Transfere extends StatefulWidget {
  String? titre;
  //
  Transfere({Key? key, this.titre}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _Transfere();
  }
}

class _Transfere extends State<Transfere> {
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
              Get.to(const DemandeTransfere());
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
            //               text: "Demande de transfère",
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
                        "Demande de transfère",
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
              Get.to(const HistoriqueTransfere());
            },
            //   style: const ButtonStyle(
            //       /*
            //     backgroundColor: MaterialStateProperty.all(
            //       Colors.blue.shade400,
            //     ),
            //     */
            //       ),
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Expanded(
            //           flex: 7,
            //           child: Container(
            //             alignment: Alignment.center, //
            //             decoration: const BoxDecoration(
            //                 //color: Colors.blue,
            //                 borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(10),
            //               topRight: Radius.circular(10),
            //             )),
            //             child: Image.asset(
            //               "assets/LOGO-MINEPST-BON.png",
            //               color: Colors.blue,
            //               colorBlendMode: BlendMode.color,
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           flex: 3,
            //           child: Container(
            //             alignment: Alignment.center,
            //             decoration: const BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(10),
            //               bottomRight: Radius.circular(10),
            //             )),
            //             child: RichText(
            //               textAlign: TextAlign.center,
            //               text: const TextSpan(
            //                 text: "Validation",
            //                 children: [
            //                   TextSpan(
            //                     text: "",
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.normal,
            //                       color: Colors.black,
            //                     ),
            //                   )
            //                 ],
            //                 style: TextStyle(
            //                   fontSize: 13,
            //                   fontWeight: FontWeight.normal,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
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
