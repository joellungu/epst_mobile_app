import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'infos_personnel.dart';

class LoginEnseignantController extends GetxController {
  //
  Requete requete = Requete();
  //
  RxMap utilisater = RxMap({});
  //
  var box = GetStorage();
  //
  Future<void> getAgent(String telephone) async {
    //
    Response rep = await requete.getE("agent/one?telephone=$telephone");

    if (rep.statusCode == 200 || rep.statusCode == 201) {
      //
      print(rep.statusCode);
      print(rep.body);
      Map e = rep.body;
      //
      Get.back();
      Get.to(InfosPersonnel(e));
      //
    } else {
      //
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de l'authentification");
    }
  }

  //
  Future<Map> login(Map e) async {
    //http://localhost:8080/agent/login?telephone=0815381693&mdp=527406480
    //print(
    //  "${Requete.url}/agent/login?telephone=${e['telephone']}&code=${e['code']}"); //
    //
    Response? rep;
    //
    rep = await requete.getE(
        "agent/login?telephone=${e['telephone']}&code=${e['code']}"); //&profil=agent

    //
    if (rep.statusCode == 200 || rep.statusCode == 201) {
      //
      print("rep:: ${rep.statusCode}");
      print("rep:: ${rep.body}");
      Map e = rep.body;
      //
      Get.back();
      // Get.snackbar(
      //   "Authentification",
      //   "Authentification reussi!t",
      //   backgroundColor: Colors.teal,
      //   colorText: Colors.white,
      // );
      //box.write("utilisateur", e);
      //Get.to(Accueil());
      return e;
      //
    } else {
      //
      Get.back();
      return {
        "status": "ERREUR",
        "message": "Un problème est survenu au serveur."
      };
      //Get.snackbar("Erreur", "Un problème lors de l'authentification");
    }
  }

  Future<void> check(Map e) async {
    print("e: $e");
    //http://localhost:8080/agent/login?telephone=0815381693&mdp=527406480
    //print(
    //  "${Requete.url}billet/check?idAgent=${e['idAgent']}&qrcode=${e['qrcode']}"); //
    //
    Response? rep;
    //
    rep = await requete.getE(
        "billet/check?idAgent=${e['idAgent']}&qrcode=${e['qrcode']}"); //&profil=agent

    //
    if (rep.statusCode == 200 || rep.statusCode == 201) {
      //
      print(rep.statusCode);
      print(rep.body);
      //String e = rep.body;
      //
      Get.back();
      Get.snackbar(
        "Authentification",
        "Authentification reussi!t",
        backgroundColor: Colors.teal,
        colorText: Colors.white,
      );
      //box.write("agent", e);
      Get.dialog(
        Center(
          child: Card(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      rep.body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //
                      Get.back();
                      //
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
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ok",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.qr_code)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      //
    } else {
      //
      Get.back();
      Get.snackbar(
        "Erreur",
        "${rep.body}",
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      Get.dialog(
        Center(
          child: Card(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "${rep.body}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //
                      Get.back();
                      //
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
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ok",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.qr_code)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> enregitrementFinal(Map e) async {
    print("Agent: :: $e");
    //http://localhost:8080/agent/login?telephone=0815381693&mdp=527406480
    //print("${Requete.url}utilisateur/"); //
    //
    Response rep = (await requete.putE("agent", e)) as Response; //&profil=agent

    //
    if (rep.statusCode == 200 || rep.statusCode == 201) {
      //
      print(rep.statusCode);
      print("Agent ::: ${rep.body}");
      //String e = rep.body;
      //
      Get.back();

      box.write("agent", rep.body);
      //
      Get.snackbar(
        "Authentification",
        "Authentification reussi!t",
        backgroundColor: Colors.teal,
        colorText: Colors.white,
      );
      //Get.offAll(Accueil());

      //
    } else {
      //
      print(rep.statusCode);
      print(rep.body);
      //
      Get.back();
      Get.snackbar(
        "Erreur",
        "${rep.body}",
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  //
}
