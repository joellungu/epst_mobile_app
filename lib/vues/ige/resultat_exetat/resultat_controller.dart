import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResultatController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  RxList liste_palmares = [].obs;
  var box = GetStorage();
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
  getListe(
    String anneescolaire,
    String codecandidat,
  ) async {
    //print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    //{nomecole}/{codeoption}/{anneescolaire}
    print(":: ::$codecandidat");
    print(":: ::$anneescolaire");
    //${Connexion.lien}
    Response response = await requete.getE(
      "palmares/resultat/$anneescolaire/$codecandidat",
    );
    if (response.isOk) {
      //
      Get.back();
      Get.back();
      print(response.body);
      //List l = response.body; //
      //
      //print("la reponse: $l");
      //
      liste_palmares.value = box.read("liste_resultats") ?? [];
      Map e = {
        "anneescolaire": anneescolaire,
        "codecandidat": codecandidat,
        "liste": response.body
      };
      liste_palmares.add(e);
      box.write('liste_resultats', liste_palmares);
      //change(liste_palmares, status: RxStatus.success());
      Get.dialog(
        const AlertDialog(
          title: Text("Resultat"),
          content: Text(
            "Votre Resultat a été téléchargé avec succès, cliquez sur 'Voir Resultat demandé'.",
          ),
        ),
      );
      //
    } else if (response.statusCode == 404) {
      //
      Get.back();
      Get.back();
      //
      liste_palmares.value = box.read("liste_resultats") ?? [];
      Map e = {
        "anneescolaire": anneescolaire,
        "codecandidat": codecandidat,
        "liste": {}
      };
      liste_palmares.add(e);
      box.write('liste_resultats', liste_palmares);
      //change(liste_palmares, status: RxStatus.success());
      Get.dialog(
        const AlertDialog(
          title: Text("Resultat"),
          content: Text(
            "Votre Resultat a été téléchargé avec succès, cliquez sur 'Voir Resultat demandé.",
          ),
        ),
      );
      //
    } else {
      //
      Get.back();
      Get.back();
      //
      print(response.statusCode);
      print(response.body);
      Get.dialog(
        AlertDialog(
          title: Text(
              "Nous n'avons pas pu trouver votre code dans le serveur dans l'année indiqué"),
          content: Text("Erreur Code: ${response.statusCode}"),
        ),
      );
      //change([], status: RxStatus.empty());
      //
    }
  }
}
