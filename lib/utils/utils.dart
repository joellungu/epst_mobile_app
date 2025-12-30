import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Utils {
  static Future<List> getNotion(
      String cours, String categorie, String banche, int classe) async {
    //
    var box = GetStorage();
    // categorie = categorie.toLowerCase();
    // //
    // cours = cours.toLowerCase();
    // //
    // Response response = await requete.getE(
    //     "cours/notion?cours=$cours&categorie=$categorie&banche=$banche&classe=$classe");
    // //
    // if (response.isOk) {
    //   //
    //   return response.body;
    // } else {
    //   //
    //   return [];
    // }
    //cours, "Maternelle", lecons[e], classe
    List notions = [];
    //
    List classeCours = box.read("classe_cours") ?? [];
    //
    for (List l in classeCours) {
      for (Map e in l) {
        if (e['cours'].toLowerCase() == cours &&
            e['categorie'].toLowerCase() == categorie &&
            e['banche'] == banche &&
            e['cls'] == classe) {
          print('notion: $e');
          notions.add(e);
        }
      }
    }
    //
    return notions;
  }

  static Color couleursCards() {
    //
    final Random _random = Random();
    //
    // Génère une couleur claire
    return Color.fromRGBO(
      _random.nextInt(128) + 127, // Valeur rouge entre 127 et 255
      _random.nextInt(128) + 127, // Valeur verte entre 127 et 255
      _random.nextInt(128) + 127, // Valeur bleue entre 127 et 255
      1,
    );
  }
}
