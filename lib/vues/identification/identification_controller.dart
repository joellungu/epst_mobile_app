import 'package:epst_app/utils/requetes.dart';
import 'package:epst_app/vues/ige/sernie/sernie.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'identification.dart';
import 'identification_sernie.dart';

class IdentificationController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  Future<Map> getStatus(String id, bool v) async {
    Response response =
        await requete.getE("${v ? 'identification' : 'piecejointe'}/$id");
    print("${v ? 'identification' : 'piecejointe'}/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("le status: ${response.body}");
      Map r = response.body;
      return r;
    } else {
      print("la reponse: ----------------");
      print("la reponse: ${response.statusCode}");
      print("la reponse: ${response.body}");
      return {"valider": 0};
    }
  }

  Future<int> setUpdate(String id, int role, int t, String raison) async {
    //
    http.Response rep = await requete.putE(
      "${role == 7 ? 'documentscolaire' : role == 13 ? 'transfere' : 'identification'}/update/$id/$t",
      raison,
    );
    //await requette.getE("mutuelle/all/demande");
    if (rep.statusCode == 200 ||
        rep.statusCode == 201 ||
        rep.statusCode == 204) {
      //

      //Get.snackbar("Effectué", "Demande expiré");
      return 1;
      //
    } else {
      print(rep.statusCode);
      print(rep.body);

      //Get.snackbar("Erreur", "Un problème est survenu lors de la validation");
      return 0;
      //getAllDemande(province, district);
    }
    //
  }

  //
  login(String matricule, String mdp) async {
    //
    Response response = await requete.getE("agent/login/$matricule/$mdp");
    if (response.isOk) {
      //
      Map e = await response.body;
      print(e);
      if (e["role"] == 7 ||
          e["role"] == 8 ||
          e["role"] == 9 ||
          e["role"] == 10 ||
          e["role"] == 13 ||
          e["role"] == 14) {
        Get.to(Identification(e));
        //
        //"Agent sernie id",
      } else if (e["role"] == 11) {
        //Les validateur
        Get.to(IdentificationSernie(e));
      } else if (e["role"] == 12) {
        //Les enregistreurs
        Get.to(Sernie(titre: "SERNIE"));
      } else {
        Get.snackbar("Erreur", "Vous n'etes pas autorisé à y acceder");
      }
    } else {
      //
      Get.snackbar(
          "Erreur", "Un problème est survenu lors de l'authentification");
    }
  }

  //sernie/getallby/Kinshasa/KINSHASA-FUNA
  getListe(int role, String province, String distric) async {
    print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    print(
        "transfere/all/demande?province=$province&district=$distric&valider=0");
    Response response = role == 7
        ? await requete.getE(
            "documentscolaire/all/demande?province=$province&district=$distric&valider=0")
        : role == 13
            ? await requete.getE(
                "transfere/all/demande?province=$province&district=$distric&valider=0")
            : await requete.getE(
                "identification/all/demande?province=$province&district=$distric&valider=0&role=$role");
    if (response.isOk) {
      //
      List l = await response.body;
      print("la reponse: $l");
      //
      change(l, status: RxStatus.success());
      //
    } else {
      print("------------------------");
      print("erreur: ${response.statusCode}");
      print("erreur: ${response.body}");
      //
      change([], status: RxStatus.empty());
      //
    }
  }

  //sernie/getallby/Kinshasa/KINSHASA-FUNA
  getListeSernie(String province, String distric, String antenne) async {
    //print("province: $province => distric: $distric");
    //identification/all/demande?province=$province&district=$distric&valider=0
    //print("sernie/getallby/Kinshasa/KINSHASA-FUNA");
    Response response =
        await requete.getE("sernie/getallby/$province/$distric/$antenne");
    //
    List la = box.read("historique_demande_sernie") ?? [];
    //
    if (response.isOk) {
      //
      List l = await response.body;

      l.forEach((element) {
        bool add = true;
        la.forEach((element2) {
          if (element2['code'] == element['code']) {
            add = false;
          }
        });
        //
        if (add) {
          la.add(element);
        }

        //
      });
      //map['photo'] = "";
      //l.add(formulaireD);
      box.write("historique_demande_sernie", la);
      //print("la reponse: $la");
      //
      change(la, status: RxStatus.success());
      //
    } else {
      print("------------------------");
      print("erreur: ${response.statusCode}");
      print("erreur: ${response.body}");
      //
      change(la, status: RxStatus.empty());
      //
    }
  }
}
