import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'requetes.dart';

class Synchronisation {
  //

  //
  static synchroEcole() async {
    //
    Requete requete = Requete();
    //
    var box = GetStorage();
    //
    Response response = await requete.getE("sernie/allecolesernie");
    if (response.isOk) {
      //
      //print("Ecoles: ${response.body}");
      box.write("ecoles_sernie", response.body);
      //
    }
  }

  //
  static synchroAgens() async {
    //
    Requete requete = Requete();
    //
    var box = GetStorage();
    //
    Response response = await requete.getE("agent/all");
    if (response.isOk) {
      //
      print("Agents: ${response.body}");
      box.write("agents", response.body);
      //
    }
  }
}
