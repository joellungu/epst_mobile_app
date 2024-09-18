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
    List classe_cours = box.read("classe_cours") ?? [];
    //
    for (List l in classe_cours) {
      for (Map e in l) {
        if (e['cours'] == cours &&
            e['categorie'] == categorie &&
            e['banche'] == banche &&
            e['classe'] == classe) {
          print('notion: $e');
          notions.add(e);
        }
      }
    }
    //
    return notions;
  }
}
