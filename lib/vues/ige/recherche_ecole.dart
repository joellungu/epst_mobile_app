import 'package:epst_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechercheEcole extends SearchDelegate {
  //List<String> liste_annee = [];
  int a = 1900;

  RechercheEcole() {
    print(liste_ecoles.length);
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
    List<Map> matchQuery = [];
    for (var annee in liste_ecoles) {
      if (annee["ecole"].toLowerCase().contains(query.toLowerCase())) {
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
            "${result["ecole"]} (${result["province"]})",
            style: TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            ecole.value = result;
            ecole1.value = result;
            ecole2.value = result;
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
    List<Map> matchQuery = [];
    for (var annee in liste_ecoles) {
      if (annee["ecole"].toLowerCase().contains(query.toLowerCase())) {
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
            "${result["ecole"]} (${result["province"]})",
            style: TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            ecole.value = result;
            ecole1.value = result;
            ecole2.value = result;
            print("salut: ${ecole.value}");
            Get.back();
            //
          },
        );
      },
    );
  }
}

class RechercheEcole2 extends SearchDelegate {
  //List<String> liste_annee = [];
  int a = 1900;

  RechercheEcole() {
    print(liste_ecoles.length);
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
    List<Map> matchQuery = [];
    for (var annee in liste_ecoles) {
      if (annee["ecole"].toLowerCase().contains(query.toLowerCase())) {
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
            "${result["ecole"]} (${result["province"]})",
            style: TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            ecole.value = result;
            //ecole1.value = result;
            ecole2.value = result;
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
    List<Map> matchQuery = [];
    for (var annee in liste_ecoles) {
      if (annee["ecole"].toLowerCase().contains(query.toLowerCase())) {
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
            "${result["ecole"]} (${result["province"]})",
            style: TextStyle(
              fontSize: 13,
            ),
          ), //
          onTap: () {
            //
            ecole.value = result;
            //ecole1.value = result;
            ecole2.value = result;
            print("salut");
            Get.back();
            //
          },
        );
      },
    );
  }
}
