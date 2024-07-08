import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:epst_app/vues/ige/sernie/sernie.dart';
import 'package:epst_app/vues/ministre/ministre.dart';
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
      Get.back();
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
      } else if (e["role"] == 15 || e["role"] == 16 || e["role"] == 17) {
        //Les enregistreurs
        Get.to(Ministre());
      } else {
        Get.snackbar("Erreur", "Vous n'etes pas autorisé à y acceder");
      }
    } else {
      //
      Get.back();
      Get.snackbar(
          "Erreur", "Un problème est survenu lors de l'authentification");
    }
  }

  //
  loginSernie(String matricule, String mdp) async {
    //
    List agents = box.read("agents") ?? [];
    //
    bool pass = false;
    //
    for (var e in agents) {
      //
      if (e["matricule"] == matricule && e["mdp"] == mdp) {
        //
        Get.back();
        //
        print(e);
        if (e["role"] == 7 ||
            e["role"] == 8 ||
            e["role"] == 9 ||
            e["role"] == 10 ||
            e["role"] == 13 ||
            e["role"] == 14) {
          pass = true;
          Get.to(Identification(e));
          break;
          //
          //"Agent sernie id",
        } else if (e["role"] == 11) {
          //Les validateur
          pass = true;
          Get.to(IdentificationSernie(e));
          break;
        } else if (e["role"] == 12) {
          //Les enregistreurs
          pass = true;
          Get.to(Sernie(titre: "SERNIE"));
          break;
        } else {
          pass = false;
          Get.snackbar("Erreur", "Vous n'etes pas autorisé à y acceder");
          break;
        }
      }
    }

    if (!pass) {
      //
      Get.back();
      Get.snackbar(
          "Erreur", "Un problème est survenu lors de l'authentification");
      //
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
    //
    final connectivityResult = await (Connectivity().checkConnectivity());
    //
    change([], status: RxStatus.loading());
    //
    if (connectivityResult == ConnectivityResult.none) {
      //
      List la = box.read("historique_demande_sernie") ?? [];
      print("la reponse: $la");

      change(la, status: RxStatus.success());
    } else {
      //

      //print("sernie/getallby/Kinshasa/KINSHASA-FUNA");
      Response response =
          await requete.getE("sernie/getallby/$province/$distric/$antenne");
      //
      List la = box.read("historique_demande_sernie") ?? [];
      //
      if (response.isOk) {
        //
        List l = await response.body;
        print("l1: ${l.length}");
        print("l2: ${la.length}");

        for (var element in l) {
          //Map c1 = element;
          //c1['photo'] = "";
          //print("c1: ${c1.toString()}");
          bool add = true;
          for (var element2 in la) {
            //Map c2 = element2;
            //c2['photo'] = "";
            //
            print(
                "test: ${element2['id'] == element['id']} ::: -1: ${element['id']} :: -2: ${element2['id']} ");
            //
            if (element2['id'] == element['id']) {
              //
              add = false;
              print("Ajouter 2: $add");
            }
          }
          //
          if (add) {
            la.add(element);
          }

          //
        }
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
}
