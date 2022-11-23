import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../utils/requetes.dart';

class MutuelleController extends GetxController {

  Requete requete = Requete();

  Future<int> getStatus(String id) async {
    Response response = await requete.getE("mutuelle/statusdem?matricule=$id");
    if(response.statusCode == 200 || response.statusCode == 201){
      print("le status: ${response.body}");
      return response.body;
    }else{
      return 0;
    }
  }

  faireUnDemande(Map map) async {
    var box = GetStorage();

    print(map);//http.
    //Response response = await requete.postE("mutuelle/demande", map);
    var response = await http.post(
      Uri.parse("${Connexion.lien}mutuelle/demande"),
      headers: {
        "Content-Type": "application/json", //"application/json",
      },
      body: json.encode(map)//element["data"],
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      print(response.statusCode);
      print(response.body);
      List l = box.read("historique") ?? [];
      map['carte'] = "";
      l.add(map);
      box.write("historique", l);
      Get.back();
      Get.snackbar("Succès", "Demande envoyé avec succès");
    }else{
      print(response.statusCode);
      print(response.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors l'envois");
    }
  }
}

