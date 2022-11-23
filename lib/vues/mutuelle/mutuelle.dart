import 'package:epst_app/vues/cours/message_phonique.dart';
import 'package:epst_app/vues/mutuelle/demande.dart';
import 'package:epst_app/vues/mutuelle/historique_demande.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mutuelle_controller.dart';

class Mutuelle extends StatefulWidget {
  String? titre;
  //
  Mutuelle({this.titre});
  //
  @override
  State<StatefulWidget> createState() {
    return _Mutuelle();
  }

}

class _Mutuelle extends State<Mutuelle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titre}"),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 7,
        childAspectRatio: 0.8,
        children: [
          ElevatedButton(
            onPressed: () {
              //
              Get.to(Demande(titre: "Demande service"));
            },
            style: const ButtonStyle(
              /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/Logo_MESP_ok.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ), //
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "Demande service",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //
              Get.to(HistoriqueDemande());
            },
            style: const ButtonStyle(
              /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/Logo_MESP_ok.png",
                        color: Colors.blue,
                        colorBlendMode: BlendMode.color,
                      ),//
                      decoration: const BoxDecoration(
                        //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "Validation",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
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
