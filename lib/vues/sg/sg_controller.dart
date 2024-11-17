import 'dart:convert';
import 'dart:io';
import 'package:epst_app/utils/requetes.dart';
import 'package:http/http.dart' as http;
import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class SgController extends GetxController with StateMixin<List> {
  //change(data, status: RxStatus.success());
  SgConnexion sgConnexion = SgConnexion();
  List<Map<String, dynamic>> liste1 = [];
  List<Map<String, dynamic>> liste2 = [];
  List<Map<String, dynamic>> liste3 = [];
  List<Map<String, dynamic>> liste4 = [];
  List<Map<String, dynamic>> liste5 = [];
  List<Map<String, dynamic>> liste6 = [];
  List<Map<String, dynamic>> liste7 = [];
  List<Map<String, dynamic>> liste11 = [];
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //

  getListeMag(int type) async {
    //
    change([], status: RxStatus.loading());
    //
    liste7 = [];
    liste11 = [];
    //
    var box = GetStorage();
    int v = 0;
    //
    var l7 = box.read("sg") ?? [];
    http.Response rep = await sgConnexion.getListeMag(type);
    print("le truc statu code: ${rep.statusCode}");
    print("Je suis à 7 == $type");
    if (rep.statusCode == 200) {
      print(rep.body);
      //
      List repListe = jsonDecode(rep.body);
      //
      for (var element in repListe) {
        Map<String, dynamic> e = element;
        print(e);
        liste7.add(e);
        /*
        //db.insert(type == 1 ? "magasin" : "reforme", element); //
        if (box.read("${e["id"]}") == null) {
          v++;
          print("+++++++++***:pas deja:***");
          //write("${e["id"]}", e["extention"], e);
        } else {
          print("+++++++++***:deja:***");
          //print(":::: $l1");
        }
        */
      }
      //print("fin de la boucle boss................................");
      //

      liste7.isEmpty ? box.write("sg", l7) : box.write("sg", liste7);
      //box.write("reforme", liste2);//
      //
      //change(liste1, status: RxStatus.success());
      change(liste7, status: RxStatus.success());
      //
      //change(l1, status: RxStatus.success());
    } else {
      box.write("sg", l7);
      //
      change(l7, status: RxStatus.success());
      //
    }
  }

  //
  Future<int> write(String id, String extension) async {
    var box = GetStorage();
    //
    final Directory directory = await getApplicationDocumentsDirectory();
    try {
      final File file = File('${directory.path}/$id.$extension');
      print(':::${directory.path}/$id.$extension');
      //bool v = await Directory('${directory.path}/$id.$extension').exists();
      //if (!v) {
      Map<String, dynamic> m = await getMagasin(id);
      box.write(id, base64Decode(m["piecejointe"]));
      File f = await file.writeAsBytes(base64Decode(m["piecejointe"])); //
      bool b = await f.exists();
      //liste11.add(e);
      //change(liste11, status: RxStatus.success());
      //print("Fichier crée avec succé ! $b");
      //  return 1;
      //}
      return 1;
      //
    } catch (e) {
      print(e);
      return 0;
    }
  }

  //
  Future<void> getAllSecretarial() async {
    change([], status: RxStatus.loading());
    Response response = await requete.getE("secretariat/all");
    if (response.isOk) {
      print("isOK");
      print(response.statusCode);
      print(response.body);
      box.write("sg", response.body);
      change(response.body, status: RxStatus.success());
    } else {
      List l = box.read("sg") ?? [];
      print("isNotOK $l");
      print(response.statusCode);
      print(response.body);
      change(l, status: RxStatus.success());
    }
  }

  //
  Future<Map> getSecretarial(String id) async {
    //change([], status: RxStatus.loading());
    Response response = await requete.getE("secretariat/detail?id=$id");
    if (response.isOk) {
      print(response.statusCode);
      print(response.body);
      box.write(id, response.body);
      return response.body;
    } else {
      print(response.statusCode);
      print(response.body);
      Map s = box.read(id) ?? {};
      return s;
    }
  }

  //
  Future<Map<String, dynamic>> getMagasin(String id) async {
    Map<String, dynamic> t = {};
    //
    //var url = Uri.parse("${Connexion.lien}magasin/$id");
    var response = await sgConnexion.getMagasin(id);
    //t = json.decode(response.body);
    //
    //==
    //
    return response.body;
  }
}

class SgConnexion extends GetConnect {
  Future<http.Response> getListeMag(int type) async {
    print("${Connexion.lien}magasin/all/$type");
    var url = Uri.parse('${Connexion.lien}magasin/all/$type');
    var response = await http.get(
      url,
      headers: {
        "Accept": "application/json, text/plain;charset=UTF-8",
        "Content-type": "application/json; charset=utf-8"
      },
    );
    print(response.statusCode);
    print(response.body);
    return response;
    /*
     headers: {
      "Accept": "application/json, text/plain;charset=UTF-8",
      "Content-type": "application/json; charset=utf-8"
    }
    */
    //print("${Connexion.lien}magasin/all/$type");
    //return get("${Connexion.lien}magasin/all/$type");
  }

  Future<Response> getMagasin(String id) async {
    var url = Uri.parse('${Connexion.lien}magasin/$id');
    var response = await get("${Connexion.lien}magasin/$id");
    return response;
    //return get("${Connexion.lien}magasin/$id");
  }
}
