import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epst_app/utils/requetes.dart';
import 'package:get/get.dart';

class PaiementController extends GetxController {
  Requete requete = Requete();
  Future<String> paiement(Map e) async {
    http.Response rep = await requete.postETicket("paiement/paie", e);
    print("la reponse du serveur: ${rep.statusCode}");
    print("la reponse du serveur: ${rep.body}");

    if (rep.statusCode == 200 || rep.statusCode == 201) {
      return rep.body;
    } else {
      return "erreur ${rep.statusCode}, ${rep.body}";
    }
  }

  Future<Map> verification(String orderNumber) async {
    var rep = await http.get(
      Uri.parse(
          "https://backend.flexpay.cd/api/rest/v1/check/orderNumer/$orderNumber"),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzk0NzYxNDYzLCJzdWIiOiJlZGZiYTY0ZTYxNjM1NWMzYjdjZDJjYzZiZTA5NzMzYiJ9.1gps60CJKzY1CP8XgAEvx8ArRAfqD9v5a9PeJr4qA6c",
      },
    );
    /**
     * timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
     */
    print(rep.statusCode);
    print(rep.body);
    //Response rep = await requete
    //  .get("http://41.243.7.46:3006/flexpay/api/rest/v1/$orderNumber");
    if (rep.statusCode == 200 || rep.statusCode == 201) {
      return jsonDecode(rep.body);
    } else {
      return jsonDecode(rep.body);
    }
  }
}
