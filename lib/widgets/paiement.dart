import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class PayementMethode extends StatefulWidget {
  Map requette;
  //
  PayementMethode(this.requette);
  //
  @override
  State<StatefulWidget> createState() {
    return _PayementMethode();
  }
}

class _PayementMethode extends State<PayementMethode> {
  RxBool load = true.obs;
  TextEditingController numero = TextEditingController();
  //
  String gender = "usd";
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Votre numéro de téléphone")],
            ),
          ),
          TextField(
            controller: numero,
            decoration: InputDecoration(
              //prefixIcon: Text("De:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: Text("Téléphone"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: RadioListTile(
                  title: Text(
                    "USD",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  value: "usd",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: RadioListTile(
                  title: Text(
                    "CDF",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  value: "cdf",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () async {
              //
              print(ecole.value);
              showDialog(
                  context: context,
                  builder: (c) {
                    return Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                              Text(
                                "Votre requette est en cours d'execution",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    );
                  });
              /*
                    String nomecole = ecole.value;
                    String codeoption = "${listeOptions[option]}".split(",")[1];
                    String anneescolaire = annee.value;
                    //
                    print("1 = $nomecole");
                    print("2 = $codeoption");
                    print("3 = $anneescolaire");
                    Get.to(
                      ListPalmares(
                          nomecole: nomecole,
                          codeoption: codeoption,
                          anneescolaire: anneescolaire),
                    );
                  
                    */
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text("Envoyer"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
