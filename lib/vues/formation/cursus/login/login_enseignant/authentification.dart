import 'package:epst_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Authentification extends StatelessWidget {
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
  //
  final formKey = GlobalKey<FormState>();
  final telephone = TextEditingController();
  final password = TextEditingController();
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
              "Meka°App",
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
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mot de passe",
                          style: textStyle,
                        ),
                      ),
                      //
                      TextFormField(
                        controller: password,
                        //textAlign: TextAlign.center,
                        //keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        //autofocus: true,
                        //focusNode: FocusNode(skipTraversal: true),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Veuilliez inserer votre adresse de residnace";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      //
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //
                          Loader.loading();
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
                          Map u = {
                            //"id": e['id'],
                            //"dateNaissance": dateNaissance.text,
                            "telephone": "243${telephone.text}",
                            "password": 1234567,
                          };
                          //
                          loginEnseignantController.enregitrementFinal(u);
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
                            "S'authentifier",
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
                      ElevatedButton(
                        onPressed: () async {
                          //
                          Get.to(Authentification());
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
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: const Text(
                            "Mot de passe oublié",
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
}
