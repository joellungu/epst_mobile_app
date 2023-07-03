import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PalmaresController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  RxList liste_palmares = [].obs;
  //
  // login(String matricule, String mdp) async {
  //   //
  //   Response response = await requete.getE("agent/login/$matricule/$mdp");
  //   if (response.isOk) {
  //     //
  //     Map e = await response.body;
  //     print(e);
  //     if (e["role"] == 7) {
  //       Get.to(Identification(e));
  //     } else {
  //       Get.snackbar("Erreur", "Vous n'etes pas autorisé à y acceder");
  //     }
  //   } else {
  //     //
  //     Get.snackbar(
  //         "Erreur", "Un problème est survenu lors de l'authentification");
  //   }
  // }
  //
  getListe(String nomprovince, String nomEcole, String option, String codeecole,
      String codeoption, String anneescolaire) async {
    //print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    //{nomecole}/{codeoption}/{anneescolaire}
    print(":: ::${codeecole.length}");
    print(":: ::$codeoption");
    print(":: ::$anneescolaire");
    print("------------------------------------------------------");
    print({
      "nomecole": nomEcole,
      "nomprovince": nomprovince,
      "codeoption": "$codeoption.0",
      "anneescolaire": anneescolaire
    });
    print("------------------------------------------------------");
    //${Connexion.lien}
    Response response = await requete.postE("actions", {
      "nomecole": nomEcole,
      "nomprovince": nomprovince,
      "codeoption": "$codeoption.0",
      "anneescolaire": anneescolaire
    });
    if (response.isOk) {
      var box = GetStorage();
      //
      print(response.body);
      List l = response.body; //
      //
      print("la reponse: $l");
      //
      liste_palmares.value = box.read("liste_palmares") ?? [];
      Map e = {
        "nomecole": nomEcole,
        "option": option,
        "codeecole": codeecole,
        "codeoption": "$codeoption.0",
        "anneescolaire": anneescolaire,
        "liste": l
      };
      liste_palmares.add(e);
      box.write('liste_palmares', liste_palmares);
      //change(liste_palmares, status: RxStatus.success());
      Get.dialog(
        const AlertDialog(
          title: Text("Palmares"),
          content: Text(
              "Votre palmares a été téléchargé avec succès, cliquez sur 'Voir palmares demandé'."),
        ),
      );
      //
    } else {
      //
      print(response.statusCode);
      print(response.body);
      Get.dialog(
        AlertDialog(
          title: Text("Erreur code: ${response.statusCode}"),
          content: Text("reponse: ${response.body}"),
        ),
      );
      //change([], status: RxStatus.empty());
      //
    }
  }
}
