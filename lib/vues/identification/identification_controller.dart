import 'package:epst_app/utils/requetes.dart';
import 'package:get/get.dart';

import 'identification.dart';

class IdentificationController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  login(String matricule, String mdp) async {
    //
    Response response = await requete.getE("agent/login/$matricule/$mdp");
    if (response.isOk) {
      //
      Map e = await response.body;
      print(e);
      if (e["role"] == 7) {
        Get.to(Identification(e));
      } else {
        Get.snackbar("Erreur", "Vous n'etes pas autorisé à y acceder");
      }
    } else {
      //
      Get.snackbar(
          "Erreur", "Un problème est survenu lors de l'authentification");
    }
  }

  //
  getListe(String province, String distric) async {
    print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    print(
        "identification/all/demande?province=$province&district=$distric&valider=0");
    Response response = await requete.getE(
        "identification/all/demande?province=$province&district=$distric&valider=0");
    if (response.isOk) {
      //
      List l = await response.body;
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
