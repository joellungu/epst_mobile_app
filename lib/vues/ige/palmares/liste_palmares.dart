import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListPalmares extends StatelessWidget {
  //
  //String? nomecole;
  //String? codeoption;
  ///String? anneescolaire;
  RxList l = [].obs;
  ListPalmares({Key? key}) : super(key: key) {
    //
    //controller.getListe(nomecole!, codeoption!, anneescolaire!);
    //
    var box = GetStorage();
    //
    //
    l.value = box.read("liste_palmares") ?? [];
    //
    print("la reponse: $l");
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste palmares"),
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
              title: Text("${e['nomecole'] ?? '...'}"),
              subtitle: Text("${e['codeoption']}"),
              trailing: Text("${e['anneescolaire']}"),
            );
          }),
        ),
      ),
    );
  }
}

class DetailsPalmares extends StatelessWidget {
  List l;
  Map e;
  DetailsPalmares(this.l, this.e, {Key? key}) : super(key: key) {
    print(l);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${e['nomecole']}\n${e['option']}: ${e['anneescolaire']}",
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
        l.isEmpty
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
            : Column(
                children: List.generate(
                  l.length,
                  (index) {
                    //
                    Map e = l[index];
                    return Row(children: [
                      Text("${index + 1}  "),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: const Icon(CupertinoIcons.person),
                          title: Text("${e['nomcandidat']}"),
                          subtitle: Text("${e['option']}"),
                          trailing: Text("${e['note']} %"),
                        ),
                      )
                    ]);
                  },
                ),
              )
      ]),
    );
  }
}
