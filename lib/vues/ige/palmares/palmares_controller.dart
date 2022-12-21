import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PalmaresController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
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
  getListe(String nomecole, String codeoption, String anneescolaire) async {
    //print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    //{nomecole}/{codeoption}/{anneescolaire}
    print(":: ::$nomecole");
    http.Response response = await http.get(
      Uri.parse(
        "${Connexion.lien}palmares?nomecole=INSTITUT MBOLIEPELE&codeoption=$codeoption&anneescolaire=$anneescolaire",
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print(response.body);
      List l = jsonDecode(response.body); //
      //
      print("la reponse: $l");
      //
      change(l, status: RxStatus.success());
      //
    } else {
      //
      change([], status: RxStatus.empty());
      //
    }
  }
}
