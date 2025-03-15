import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'paiement_controller.dart';

class PayementMethode extends StatefulWidget {
  Map requette;
  double prix;
  Function f;
  String? type;
  String? demande;
  //
  PayementMethode(this.requette, this.prix, this.f, this.demande, this.type,
      {Key? key})
      : super(key: key);
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
  String gender = "USD";
  Timer? t;
  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //t!.cancel();
  }

  //
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Votre numéro de téléphone")],
            ),
          ),
          TextField(
            controller: numero,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefix: const Text("+243"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Téléphone"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Formulaire payant (${widget.prix} dollar) plus frais de transaction",
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: RadioListTile(
                  title: const Text(
                    "USD",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  value: "USD",
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
                  title: const Text(
                    "CDF",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  value: "CDF",
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
              if (numero.text.length == 9) {
                print("le numéro:243${numero.text}");
                //
                PaiementController paiementController = Get.find();
                //
                Get.dialog(
                  const Material(
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
                //
                var ref = getReference();
                DateTime d = DateTime.now();
                Map e = {
                  "nom": widget.requette['nom'] ?? "",
                  "postnom": widget.requette['postnom'] ?? "",
                  "prenom": widget.requette['prenom'] ?? "",
                  "date": "${d.day}/${d.month}/${d.year}",
                  "type": widget.type,
                  "demande": widget.demande,
                  "phone": "243${numero.text}",
                  "reference": ref,
                  "amount": 500, // widget.prix,
                  "currency": "CDF" // gender,
                };
                print('element: $e');
                http.Response m = await paiementController.paiement(e);
                print("la reponse du serveur: $m");
                if (m.statusCode == 200 || m.statusCode == 201) {
                  //La fonction bloucle...
                  //Get.back();
                  if (jsonDecode(m.body)['code'] == "0") {
                    widget.f(widget.requette);
                  } else {
                    //
                    //widget.f(widget.requette); // En attendant...
                    //
                    Get.back();
                    Get.back();
                    Get.dialog(
                      Center(
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 130,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Un problème est survenu lors du paiement le code d'erreur est: ${jsonDecode(m.body)['code']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Compris"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  //
                  Get.back();
                  Get.back();
                  Get.dialog(
                    Center(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 130,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Un problème est survenu lors du paiement le code d'erreur est: ${m.statusCode}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Compris"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  //
                }

                /*
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
                  */
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
              } else {
                Get.snackbar("Erreur", "Le numéro est incorrecte");
              }
              print(ecole.value);
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

  //
  String getReference() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}
