import 'dart:math';
import 'package:epst_app/vues/formation/cursus/login/login_enseignant/login_controller.dart';
import 'package:epst_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'authentification.dart';
import 'login_controller.dart';

class LoginEnseignant extends StatelessWidget {
  //
  // Map e;
  // //
  // Login(this.e) {
  //   telephone.text = e['telephone'];
  //   noms.text = e['noms'] ?? '';
  //   genre.text = e['genre'] ?? '';
  //   adresse.text = e['adresse'] ?? '';
  //   dateNaissance.text = e['dateNaissance'] ?? '';
  // }
  var box = GetStorage();
  //
  final formKey = GlobalKey<FormState>();
  final telephone = TextEditingController();
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  final dateNaissance = TextEditingController();
  final genre = TextEditingController();
  final lieuExcercice = TextEditingController();
  final province = TextEditingController();
  final email = TextEditingController();
  //
  String codePays = "+243";
  //
  RxBool vue = true.obs;

  LoginEnseignantController loginEnseignantController = Get.find();
  //
  RxBool masquer = true.obs;

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      color: Colors.black, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          //backgroundColor: Loader.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "FOAD MOBILE",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            elevation: 0,
            //backgroundColor: Loader.backgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Téléphone",
                          style: textStyle,
                        ),
                      ),
                      //
                      TextFormField(
                        controller: telephone,
                        //enabled: false,
                        textCapitalization: TextCapitalization.words,
                        //textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        //autofocus: true,
                        //focusNode: FocusNode(skipTraversal: true),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Veuilliez inserer votre numéro de téléphone";
                          } else if (e!.length >= 10) {
                            return "Le numéro n'est pas correct !";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefix: Text(
                            "00243 ",
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //
                          Loader.loading();
                          String token = box.read("token") ?? "";
                          /**
                           * agent1.nom = agent.nom;
                            agent1.postnom = agent.nom;
                            agent1.prenom = agent.nom;
                            agent1.telephone = agent.nom;
                            agent1.email = agent.nom;
                            agent1.adresse = agent.nom;
                            agent1.actif = agent.actif;
                            agent1.province = agent.nom;
                            agent1.commune = agent.nom;
                            agent1.lieuExcercie = agent.nom;
                            agent1.password = agent.password;
                           */
                          //
                          // Map u = {
                          //   //"id": e['id'],
                          //   "nom": nom.text,
                          //   "postnom": postnom.text,
                          //   "prenom": prenom.text,
                          //   "genre": genre.text,
                          //   //"dateNaissance": dateNaissance.text,
                          //   "telephone": "243${telephone.text}",
                          //   "adresse": adresse.text,
                          //   "actif": true,
                          //   "province": province.text,
                          //   "lieuExcercie": lieuExcercice.text,
                          //   "password": 1234567,
                          //   "fbToken": token,
                          // };
                          //
                          //Loader.loading();
                          //
                          String code = mdpGenerer();
                          //
                          Map e = {
                            "telephone": "243${telephone.text}",
                            "code": code,
                          };
                          //
                          // Get.dialog(
                          //   Center(
                          //     child: Container(
                          //       height: 40,
                          //       width: 40,
                          //       child: const CircularProgressIndicator(),
                          //     ),
                          //   )
                          // );
                          //
                          Map rep = await loginEnseignantController.login(e);
                          //
                          if (rep['status'] == 'SENT') {
                            //
                            TextEditingController otp = TextEditingController();
                            //
                            Get.dialog(
                              Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Card(
                                    elevation: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 300,
                                      width: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Veuillez inserer le code que vous avez reçu par SMS",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            controller: otp,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.numbers),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    //
                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Size(
                                                        double.maxFinite,
                                                        45,
                                                      ),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .deepOrange),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: double.maxFinite,
                                                    child: const Text(
                                                      "Annuler",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    //
                                                    Get.back();
                                                    if (otp.text == code) {
                                                      //
                                                      Loader.loading();
                                                      //

                                                      //
                                                      loginEnseignantController
                                                          .getAgent(
                                                              "243${telephone.text}");
                                                      //
                                                    } else {
                                                      //
                                                      Get.snackbar("Oups",
                                                          "Code incorrect veuillez reessayer");
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Size(
                                                        double.maxFinite,
                                                        45,
                                                      ),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Color.fromARGB(
                                                          255, 0, 90, 23),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: double.maxFinite,
                                                    child: const Text(
                                                      "Valider",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  //VerificationNumero(u, code),
                                ),
                              ),
                            );
                          }
                          //loginController.enregitrementFinal(u);
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(
                              double.maxFinite,
                              45,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: const Text(
                            "Enregistrer",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              //
                            },
                            child: const Text(
                              "Condition d'utilisation",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  //)
                ),
              ),
            ),
          ),

          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     text: "Power by\n",
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     children: [
          //       TextSpan(
          //         text: "SkyTechnologie",
          //         style: TextStyle(
          //           color: Colors.grey.shade700,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  //
  TextStyle textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  //
  String mdpGenerer() {
    //
    var r = Random();
    //
    String code = "";
    //
    for (int t = 0; t < 7; t++) {
      code = "$code${r.nextInt(9)}";
    }
    //
    return code;
  }
}
