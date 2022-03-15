import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class Connexion {
  //
  static var lien = 'http://192.168.1.168:8080/';
  //
  static Future<String> enregistrement(Map<String, dynamic> utilisateur) async {
    //
    print("utilisateur: ${json.encode(utilisateur)}");
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
    //print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      String r = response.body;
      if (r == "0") {
        return "0";
      } else {
        return r;
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
}
