import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/models/magasin.dart';
import 'package:epst_app/models/reforme.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Connexion {
  //
  //static var lien = 'http://10.0.2.2:8080/';
  static var lien = 'https://epstapp.herokuapp.com/';
  //static var lien = 'http://192.168.43.2:8080/';
  //
  static Future<String> enregistrement(Map<String, dynamic> utilisateur) async {
    //
    print("utilisateur: ${json.encode(utilisateur)}");
    Historique h = Historique();
    Database db = await h.openDB();
    //
    var url = Uri.parse(lien + "plainte");
    //
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(utilisateur),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //
    //print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> r = jsonDecode(response.body);
      if ("${r["save"]}" == "0") {
        return "0";
      } else {
        //
        db.insert("historique", utilisateur);
        //
        return "${r["save"]}";
      }
    } else {
      return "0";
    }
    //return "${response.body}";
  }

  //
  static Future<String> enregistrementPiecejointe(
      String id, List<Map<String, dynamic>> e) async {
    //
    //

    e.forEach(
      (element) async {
        //
        var url = Uri.parse(lien + "piecejointe/$id/${element["type"]}");
        //element ;
        //var stream = new http.ByteStream(DelegatingStream.typed(element["type"]));
        var length = await element["length"];
        print("------------------------");
        print(element["type"]);
        print(id);
        print("------------------------");
        //List<String> extT = element.path.split(".");
        //String ext = extT.last;
        //substring(element.path.length - 4, element.path.length)
/*
      var request = http.MultipartRequest("POST", url);
      var multipartFile = http.MultipartFile(
          'file', Stream.value(element["data"]), length,
          filename: "gichier.${element["data"]}");
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
*/

        Map<String, dynamic> map = {
          "piecejointe_id": id,
          "donne": element["data"],
          "type": element["type"]
        };
        var response = await http.post(
          url,
          headers: {
            "Content-Type": "multipart/form-data", //"application/json",
          },
          body: element["data"],
        );
        //
        print("_____________: ${response.body}");
        print("_____________: ${response.headers}");
        print("_____________: ${response.statusCode}");
        print("_____________: ${response.contentLength}");
      },
    );

    return "";
  }

  //
  static Future<List<Map<String, dynamic>>> liste_magasin(int type) async {
    List<Map<String, dynamic>> liste = [];
    //
    var url = Uri.parse(lien + "magasin/all/$type");
    var response = await http.get(url);
    //
    //
    Magasin magasin = Magasin();
    Reforme reforme = Reforme();
    //
    Database db = await magasin.openDB();
    if (type == 1) {
      db = await magasin.openDB();
    } else {
      db = await reforme.openDB();
    }
    //
    List rep_liste = json.decode(response.body);
    rep_liste.forEach((element) {
      Map<String, dynamic> e = element;
      print(e);
      liste.add(e);
      db.insert(type == 1 ? "magasin" : "reforme", element); //

      _write("${e["id"]}", e["extention"]);
    });

    return liste;
  }

  //
  static _write(String id, String extension) async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final File file = File('${directory.path}/$id.$extension');
    bool v = await Directory('${directory.path}/$id.$extension').exists();
    if (!v) {
      Map<String, dynamic> m = await getMagasin(id);
      File f = await await file.writeAsBytes(base64Decode(m["piecejointe"])); //
      bool b = await f.exists();
      print("Fichier crée avec succé ! $b");
    }
    //
  }

  //
  static Future<Map<String, dynamic>> getMagasin(String id) async {
    Map<String, dynamic> t = {};
    //
    var url = Uri.parse(lien + "magasin/$id");
    var response = await http.get(url);
    t = jsonDecode(response.body);
    //
    return t;
  }
  //
}
