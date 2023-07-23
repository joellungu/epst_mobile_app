import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../utils/requetes.dart';

class MutuelleController extends GetxController {
  Requete requete = Requete();

  Future<Map> getStatus(String id) async {
    Response response = await requete.getE("mutuelle/$id");
    print("mutuelle/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("mutuelle le status: ${response.body}");
      return response.body;
    } else {
      return {"valider": 0};
    }
  }

  setSaturer(State st, List l, int t, String id, String cenome) async {
    //
    Response rep = await requete.getE("mutuelle/saturer/$id/$cenome/3");
    //await requette.getE("mutuelle/all/demande");
    if (rep.statusCode == 200 ||
        rep.statusCode == 201 ||
        rep.statusCode == 204) {
      //getAllDemande(province, district);

      //l.removeAt(t);
      l[t]['valider'] = 3;
      //
      Get.snackbar("Effectué", "Demande expiré");
      //
      var box = GetStorage();
      box.write("historique", l);
      st.setState(() {});
    } else {
      print(rep.statusCode);
      print(rep.bodyString);

      Get.snackbar("Erreur", "Un problème est survenu lors de la validation");
      //getAllDemande(province, district);
    }
    //
  }

  faireUnDemande(Map map) async {
    var box = GetStorage();

    print(map); //http.
    //Response response = await requete.postE("mutuelle/demande", map);
    var response =
        await http.post(Uri.parse("${Connexion.lien}mutuelle/demande"),
            headers: {
              "Content-Type": "application/json", //"application/json",
            },
            body: json.encode(map) //element["data"],
            );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      Map m = jsonDecode(response.body);
      List l = box.read("historique") ?? [];
      m['carte'] = "";
      l.add(m);
      box.write("historique", l);
      Get.back();
      Get.snackbar("Succès", "Demande envoyé avec succès");
    } else {
      print(response.statusCode);
      print(response.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors l'envois");
    }
  }
}
