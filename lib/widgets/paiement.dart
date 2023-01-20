import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../main.dart';
import 'paiement_controller.dart';

class PayementMethode extends StatefulWidget {
  Map requette;
  double prix;
  Function f;
  String? type;
  String? demande;
  //
  PayementMethode(this.requette, this.prix, this.f, this.demande, this.type);
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
      height: 300,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Votre numéro de téléphone")],
            ),
          ),
          TextField(
            controller: numero,
            decoration: InputDecoration(
              prefix: const Text("+243"),
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
          Text(
            "Formulaire payant (1 dollar) plus frais de transaction",
            textAlign: TextAlign.center,
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
                  title: Text(
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
                print("le numéro:" "243" + numero.text);
                //
                PaiementController paiementController = Get.find();
                //
                Get.dialog(
                  const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
                var ref = getReference();
                DateTime d = DateTime.now();
                Map e = {
                  "nom": widget.requette['nom'] ?? "",
                  "postnom": widget.requette['postnom'] ?? "",
                  "prenom": widget.requette['prenom'] ?? "",
                  "date": "${d.day}/${d.month}/${d.year}",
                  "type": widget.type,
                  "demande": widget.demande,
                  "phone": "243" + numero.text,
                  "reference": ref,
                  "amount": widget.prix,
                  "currency": gender,
                };
                Map m = await paiementController.paiement(e);
                print("la reponse du serveur: $m");
                if (m['code'] != null) {
                  //La fonction bloucle...
                  //Get.back();

                  Timer(Duration(seconds: 5), () async {
                    //
                    Timer? t;
                    t = Timer.periodic(const Duration(seconds: 5),
                        (timer) async {
                      var rep = await paiementController
                          .verification(m['orderNumber']);
                      print("La vérification: $rep");
                      //
                      if (rep['status'] == null) {
                        if (rep['code'] == 0 || rep['code'] == "0") {
                          //USSD bien envoyé
                          if (rep['transaction']['status'] == "1" ||
                              rep['transaction']['status'] == 1) {
                            //Paiement non éffectué
                            print(widget.requette);
                            t!.cancel();
                            Get.back();
                            Get.snackbar(
                              "Notification",
                              "Le paiement n'a pas reussi",
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                            );
                          } else {
                            t!.cancel();
                            Get.back();
                            //widget.f(widget.requette);
                          }
                        } else {
                          //USSD non envoyé
                          t!.cancel();
                          Get.back();
                          Get.back();
                          Get.snackbar(
                            "Notification",
                            rep['message'] ??
                                "Erreur lors du paiement code d'erreur 1",
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                          );
                        }
                      } else {
                        print("pass");
                      }
                    });
                  });
                } else {
                  //
                  Get.back();
                  Get.snackbar(
                    "Erreur",
                    m['message'],
                    backgroundColor: Colors.blue,
                    colorText: Colors.white,
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
    var uuid = Uuid();
    return "${uuid.v4()}";
  }
}