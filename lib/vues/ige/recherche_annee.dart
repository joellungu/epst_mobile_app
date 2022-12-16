import 'package:epst_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechercheAnnee extends SearchDelegate {
  List<String> liste_annee = [];
  int a1 = 1900;
  int a2 = 1901;

  RechercheAnnee() {
    for (int i = 0; i < 400; i++) {
      liste_annee.add("$a1-$a2");
      a1++;
      a2++;
    }
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
    List<String> matchQuery = [];
    for (var annee in liste_annee) {
      if (annee.toLowerCase().contains(query.toLowerCase())) {
        //var result = matchQuery[]
        matchQuery.add(annee);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            //
            annee.value = result;
            print("salut");
            Get.back();
            //
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var annee in liste_annee) {
      if (annee.toLowerCase().contains(query.toLowerCase())) {
        //var result = matchQuery[]
        matchQuery.add(annee);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            //
            annee.value = result;
            print("salut");
            Get.back();
            //
          },
        );
      },
    );
  }
}
