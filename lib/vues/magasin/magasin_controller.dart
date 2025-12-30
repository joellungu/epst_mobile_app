import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart' as g;
import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class MagasinController extends GetxController with StateMixin<List> {
  //change(data, status: RxStatus.success());

  //
  MagasinConnexion magasinConnexion = MagasinConnexion();
  List<Map<String, dynamic>> liste1 = [];
  List<Map<String, dynamic>> liste2 = [];
  List<Map<String, dynamic>> liste3 = [];
  List<Map<String, dynamic>> liste4 = [];
  List<Map<String, dynamic>> liste5 = [];
  List<Map<String, dynamic>> liste6 = [];
  List<Map<String, dynamic>> liste7 = [];
  List<Map<String, dynamic>> liste11 = [];
  //
  getListeMag(int type, bool localData) async {
    //
    change([], status: RxStatus.loading());
    //
    liste1 = [];
    liste2 = [];
    liste3 = [];
    liste4 = [];
    liste5 = [];
    liste6 = [];
    liste7 = [];
    liste11 = [];
    //
    var box = GetStorage();
    int v = 0;
    //
    var l1 = box.read("magasin") ?? [];
    var l2 = box.read("reforme") ?? [];
    var l3 = box.read("am") ?? [];
    var l4 = box.read("na") ?? [];
    var l5 = box.read("nc") ?? [];
    var l6 = box.read("mp") ?? [];
    var l7 = box.read("sg") ?? [];
    //
    if (localData) {
      //
      http.Response rep = await magasinConnexion.getListeMag(type);
      print("le truc statu code: ${rep.body}");
      print("Je suis à 7 == $type");
      if (rep.statusCode == 200 || rep.statusCode == 201) {
        print(rep.body);
        //
        List repListe = jsonDecode(rep.body);
        //
        for (var element in repListe) {
          Map<String, dynamic> e = element;
          print(e);
          if (type == 1) {
            liste1.add(e);
          } else if (type == 2) {
            liste2.add(e);
          } else if (type == 3) {
            liste3.add(e);
          } else if (type == 4) {
            liste4.add(e);
          } else if (type == 5) {
            liste5.add(e);
          } else if (type == 6) {
            liste6.add(e);
          } else if (type == 7) {
            liste7.add(e);
          }
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
        liste1.isEmpty
            ? box.write("magasin", l1)
            : box.write("magasin", liste1);
        liste2.isEmpty
            ? box.write("reforme", l2)
            : box.write("reforme", liste2);
        liste3.isEmpty ? box.write("am", l3) : box.write("am", liste3);
        liste4.isEmpty ? box.write("na", l4) : box.write("na", liste4);
        liste5.isEmpty ? box.write("nc", l5) : box.write("nc", liste5);
        liste6.isEmpty ? box.write("mp", l6) : box.write("mp", liste6);
        liste7.isEmpty ? box.write("sg", l7) : box.write("sg", liste7);
        //box.write("reforme", liste2);//
        //
        //change(liste1, status: RxStatus.success());
        if (type == 1) {
          
          change(liste1, status: RxStatus.success());
        } else if (type == 2) {
          change(liste2, status: RxStatus.success());
        } else if (type == 3) {
          change(liste3, status: RxStatus.success());
        } else if (type == 4) {
          change(liste4, status: RxStatus.success());
        } else if (type == 5) {
          change(liste5, status: RxStatus.success());
        } else if (type == 6) {
          change(liste6, status: RxStatus.success());
        } else if (type == 7) {
          change(liste7, status: RxStatus.success());
        }
        //
        //change(l1, status: RxStatus.success());
      } else {
        box.write("magasin", l1);
        box.write("reforme", l2);
        box.write("am", l3);
        box.write("na", l4);
        box.write("nc", l5);
        box.write("mp", l6);
        box.write("sg", l7);
        //
        if (type == 1) {
          change(l1, status: RxStatus.success());
        } else if (type == 2) {
          change(l2, status: RxStatus.success());
        } else if (type == 3) {
          change(l3, status: RxStatus.success());
        } else if (type == 4) {
          change(l4, status: RxStatus.success());
        } else if (type == 5) {
          change(l5, status: RxStatus.success());
        } else if (type == 6) {
          change(l6, status: RxStatus.success());
        } else if (type == 7) {
          change(l7, status: RxStatus.success());
        }
        //
      }
    } else {
      box.write("magasin", l1);
      box.write("reforme", l2);
      box.write("am", l3);
      box.write("na", l4);
      box.write("nc", l5);
      box.write("mp", l6);
      box.write("sg", l7);
      //
      if (type == 1) {
        change(l1, status: RxStatus.success());
      } else if (type == 2) {
        change(l2, status: RxStatus.success());
      } else if (type == 3) {
        change(l3, status: RxStatus.success());
      } else if (type == 4) {
        change(l4, status: RxStatus.success());
      } else if (type == 5) {
        change(l5, status: RxStatus.success());
      } else if (type == 6) {
        change(l6, status: RxStatus.success());
      } else if (type == 7) {
        change(l7, status: RxStatus.success());
      }
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
  Future<Map<String, dynamic>> getMagasin(String id) async {
    Map<String, dynamic> t = {};
    //
    //var url = Uri.parse("${Connexion.lien}magasin/$id");
    var response = await magasinConnexion.getMagasin(id);
    print(response.body);
    //t = json.decode(response.body);
    //
    //==
    //
    return jsonDecode(response.body);
  }
}

class MagasinConnexion extends GetConnect {
  //
  //final dio = g.Dio();
  //
  Future<http.Response> getListeMag(int type) async {
    print("${Connexion.lien}magasin/all/$type");
    //var url = Uri.parse('${Connexion.lien}magasin/all/$type');
    var response = await http.get(
      Uri.parse('${Connexion.lien}magasin/all/$type'),
      headers: {
        "Accept": "application/json, text/plain;charset=UTF-8",
        "Content-type": "application/json; charset=utf-8"
      },
    );
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

  Future<http.Response> getMagasin(String id) async {
    var url = Uri.parse('${Connexion.lien}magasin/$id');
    var response = await http.get(Uri.parse("${Connexion.lien}magasin/$id"));
    return response;
    //return get("${Connexion.lien}magasin/$id");
  }
}
