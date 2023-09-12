import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListResultat extends StatelessWidget {
  //
  //String? nomecole;
  //String? codeoption;
  ///String? anneescolaire;
  RxList l = [].obs;
  ListResultat({Key? key}) : super(key: key) {
    //
    //controller.getListe(nomecole!, codeoption!, anneescolaire!);
    //
    var box = GetStorage();
    //liste_resultats
    //
    l.value = box.read("liste_resultats") ?? [];
    //
    print("la reponse: $l");
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste résultats"),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: List.generate(l.length, (index) {
            Map e = l[index];
            print(e);
            return ListTile(
              onTap: () {
                //
                Map r = {
                  "nomecole": "${e['nomecole']}",
                  "option": "${e['option']}",
                  "anneescolaire": "${e['anneescolaire']}",
                };
                Get.to(DetailsPalmares(e['liste'], r));
                //
              },
              // leading: Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: NetworkImage(
              //             "${Connexion.lien}identification/piecejointe/${e['id']}")),
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   //child: Image.network(
              //   //  "${Connexion.lien}identification/piecejointe/${e['id']}"),
              // ),
              title: Text("${e['codecandidat'] ?? '...'}".split(".")[0]),
              subtitle: Text("${e['anneescolaire']}"),
              //trailing: Text("${e['anneescolaire']}"),
            );
          }),
        ),
      ),
    );
  }
}

class DetailsPalmares extends StatelessWidget {
  Map? l;
  Map e;
  DetailsPalmares(this.l, this.e, {Key? key}) : super(key: key) {
    print(l);
  }
  @override
  Widget build(BuildContext context) {
    print(l);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${l!['nomecole']}\n${l!['option']}: ${e['anneescolaire']}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(10), children: [
        Image.asset(
          "assets/LOGO-MINEPST-BON.png",
          height: 100,
          width: 100,
          //color: Colors.white,
          //colorBlendMode: BlendMode.color,
        ),
        const SizedBox(
          height: 30,
        ),
        // ignore: unnecessary_null_comparison
        l == null
            ? Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: const Text.rich(
                  TextSpan(
                    text:
                        "Aucun resultat n'a été trouvé, veuillez recommencer ou contacter le ",
                    children: [
                      TextSpan(
                        text: "178",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Felicitation ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                  children: [
                    TextSpan(
                      text: "${l!['nomcandidat']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const TextSpan(text: " Vous-avez réussi aux Examens d'Etat avec"),
                    TextSpan(
                      text: " ${l!['note']} % \n\n",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    WidgetSpan(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Télécharger votre attestation de reussit \n(4 dollars)",
                        textAlign: TextAlign.center,
                      ),
                    ))
                  ],
                ),
              )
      ]),
    );
  }
}
