import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'palmares_controller.dart';

class ListPalmares extends GetView<PalmaresController> {
  //
  String? nomecole;
  String? codeoption;
  String? anneescolaire;
  ListPalmares({this.anneescolaire, this.codeoption, this.nomecole}) {
    //
    controller.getListe(nomecole!, codeoption!, anneescolaire!);
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste palmares"),
      ),
      body: controller.obx(
        (state) {
          List l = state!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: List.generate(l.length, (index) {
              Map e = l[index];
              return ListTile(
                onTap: () {
                  //
                  //Get.to(Details(e));
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
                title: Text("${e['nomcandidat']}"),
                subtitle: Text("sexe: ${e['sexe']}"),
                trailing: Text("${e['note']} %"),
              );
            }),
          );
        },
        onEmpty: Container(),
        onError: (e) {
          return Container();
        },
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
