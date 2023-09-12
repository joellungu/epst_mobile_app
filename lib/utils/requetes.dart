import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'connexion.dart';

class Requete extends GetConnect {
  Future<Response> getE(String path) async {
    print(path);
    return get("${Connexion.lien}$path");
  }

  Future<Response> postE(String path, var e) async {
    print("${Connexion.lien}$path");
    return post("${Connexion.lien}$path", e);
  }

  Future<http.Response> postEE(String path, Map e) async {
    print("${Connexion.lien}$path");
    var url = Uri.parse("${Connexion.lien}$path");
    var response = await http.post(url, body: jsonEncode(e));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }

  Future<http.Response> putE(String path, dynamic e) async {
    print("${Connexion.lien}$path");
    var url = Uri.parse("${Connexion.lien}$path");
    var response = await http.put(url, body: jsonEncode(e), headers: {
      "Content-Type": "application/json",
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }
}
