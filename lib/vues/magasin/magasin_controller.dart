import 'dart:convert';
import 'dart:io';

import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class MagasinController extends GetxController with StateMixin<List> {
  //change(data, status: RxStatus.success());
  MagasinConnexion magasinConnexion = MagasinConnexion();
  List<Map<String, dynamic>> liste1 = [];
  List<Map<String, dynamic>> liste11 = [];
  List<Map<String, dynamic>> liste2 = [];
  //
  getListeMag(int type) async {
    //
    liste1 = [];
    liste11 = [];
    liste2 = [];
    //
    var box = GetStorage();
    int v = 0;
    //
    var l1 = box.read("magasin");
    var l2 = box.read("reforme");
    Response rep = await magasinConnexion.getListeMag(1);
    if (rep.isOk) {
      print(rep.body);
      List rep_liste = rep.body;
      //
      rep_liste.forEach((element) {
        Map<String, dynamic> e = element;
        print(e);
        if (type == 1) {
          liste1.add(e);
        }
        /*
        else {
          liste2.add(e);
        }
        */
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
      });
      print("fin de la boucle boss................................");
      //
      liste1.isEmpty ? box.write("magasin", l1) : box.write("magasin", liste1);
      liste2.isEmpty ? box.write("reforme", l2) : box.write("reforme", liste2);
      //box.write("reforme", liste2);//
      change(liste1, status: RxStatus.success()); //
      //change(l1, status: RxStatus.success());
    } else {
      box.write("magasin", l1);
      box.write("reforme", l2);
      //
      change(l1, status: RxStatus.success());
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
      return 2;
    }
  }

  //
  Future<Map<String, dynamic>> getMagasin(String id) async {
    Map<String, dynamic> t = {};
    //
    //var url = Uri.parse("${Connexion.lien}magasin/$id");
    var response = await magasinConnexion.getMagasin("$id");
    t = response.body;
    //
    //==
    //
    return t;
  }
}

class MagasinConnexion extends GetConnect {
  Future<Response> getListeMag(int type) async {
    return get("${Connexion.lien}magasin/all/$type");
  }

  Future<Response> getMagasin(String id) async {
    return get("${Connexion.lien}magasin/$id");
  }
}
