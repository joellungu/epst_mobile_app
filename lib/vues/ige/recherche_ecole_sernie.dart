import 'package:epst_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RechercheEcoleSernie extends SearchDelegate {
  List liste_ecoles_sernie = [];
  //
  var box = GetStorage();
  //
  int a = 1900;

  RechercheEcoleSernie() {
    liste_ecoles_sernie = box.read("ecoles_sernie") ?? [];
    print(liste_ecoles_sernie.length);
    // for (int i = 0; i < liste_ecoles.length; i++) {
    //   liste_annee.add(liste_ecoles[i]);
    //   a++;
    // }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var annee in liste_ecoles_sernie) {
      if (annee["denomination_ecole"]
          .toLowerCase()
          .contains(query.toLowerCase())) {
        //var result = matchQuery[]
        matchQuery.add(annee);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        Map result = matchQuery[index];
        return ListTile(
          title: Text(
            "${result["denomination_ecole"]} (${result["code_ecole"]})",
            style: const TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            //ecole_sernie.value = result;
            ecole_sernie["denomination_ecole"] = result['denomination_ecole'];
            ecole_sernie["code_ecole"] = result['code_ecole'];

            //ecole1.value = result;
            //ecole2.value = result;
            print("salut: ${ecole.value}");
            Get.back();
            //
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var annee in liste_ecoles_sernie) {
      if (annee["denomination_ecole"]
          .toLowerCase()
          .contains(query.toLowerCase())) {
        //var result = matchQuery[]
        matchQuery.add(annee);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        Map result = matchQuery[index];
        return ListTile(
          title: Text(
            "${result["denomination_ecole"]} (${result["code_ecole"]})",
            style: const TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            ecole_sernie["denomination_ecole"] = result['denomination_ecole'];
            ecole_sernie["code_ecole"] = result['code_ecole'];
            // ecole1.value = result;
            // ecole2.value = result;
            print("salut: ${ecole.value}");
            Get.back();
            //
          },
        );
      },
    );
  }
}
