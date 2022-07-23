import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';

class DepotPlainteController extends GetxController with StateMixin<String> {
  //
  DepotPlainteConnexion depotPlainteConnexion = DepotPlainteConnexion();
  envoyerPlainte(Map<String, dynamic> p) async {
    //
    Response rep = await depotPlainteConnexion.envoyerPlainte(p);
    if (rep.isOk) {
    } else {}
  }
}

class DepotPlainteConnexion extends GetConnect {
  Future<Response> envoyerPlainte(Map<String, dynamic> p) async {
    return post("${Connexion.lien}plainte", jsonEncode(p)); //
  }

  Future<Response> getMagasin(String id) async {
    return get("${Connexion.lien}magasin/$id");
  }
}
