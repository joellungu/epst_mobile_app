import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DemandeDocumentController extends GetxController {
  Requete requete = Requete();

  Future<Map> getStatus(String id) async {
    Response response = await requete.getE("documentscolaire/$id");
    print("documentscolaire/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("le status: ${response.body}");
      return response.body;
    } else {
      print("-----------------------------");
      print("erreur du à&: ${response.statusCode}");
      print("erreur du à: ${response.body}");
      return {"valider": 0};
    }
  }

  setSaturer(State st, List l, int t, String id, String cenome) async {
    //
    Response rep = await requete.getE("documentscolaire/saturer/$id/$cenome/3");
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

  faireUneDemande(Map map) async {
    var box = GetStorage();

    print(map); //http.
    //Response response = await requete.postE("identification/demande", map);
    var response = await http.post(
        Uri.parse("${Connexion.lien}documentscolaire/enregistrement"),
        headers: {
          "Content-Type": "application/json", //"application/json",
        },
        body: json.encode(map) //element["data"],
        );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      Map e = jsonDecode(response.body);
      print(e);
      List l = box.read("historique_document") ?? [];
      e['photo'] = "";
      l.add(e);
      box.write("historique_document", l);
      Get.back();
      Get.snackbar("Succès", "Demande envoyé avec succès");
      Get.dialog(
        AlertDialog(
          title: const Text("Succès"),
          content: const Text("Demande envoyé avec succès"),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    } else {
      print(response.statusCode);
      print(response.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors l'envois");
      Get.dialog(
        AlertDialog(
          title: const Text("Erreur"),
          content: const Text("Un problème est survenu lors l'envois"),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    }
  }

  //
  faireUneDemandeDiplome(Map map) async {
    var box = GetStorage();

    print(map); //http.
    //Response response = await requete.postE("identification/demande", map);
    var response =
        await http.post(Uri.parse("${Connexion.lien}diplome/enregistrement"),
            headers: {
              "Content-Type": "application/json", //"application/json",
            },
            body: json.encode(map) //element["data"],
            );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      Map e = jsonDecode(response.body);
      print(e);
      List l = box.read("historique_document") ?? [];
      e['photo'] = "";
      l.add(e);
      box.write("historique_document", l);
      Get.back();
      Get.snackbar("Succès", "Demande envoyé avec succès");
      Get.dialog(
        AlertDialog(
          title: const Text("Succès"),
          content: const Text("Demande envoyé avec succès"),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    } else {
      print(response.statusCode);
      print(response.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors l'envois");
      Get.dialog(
        AlertDialog(
          title: const Text("Erreur"),
          content: const Text("Un problème est survenu lors l'envois"),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    }
  }
}
