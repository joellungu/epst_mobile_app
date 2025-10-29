import 'package:epst_app/vues/magasin/magasin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AttestationReussit extends GetView<MagasinController> {
  //
  bool? localData;
  //
  AttestationReussit({Key? key, this.titre, this.localData: true})
      : super(key: key) {
    controller.getListeMag(4, localData!);
  }
  //
  String? titre;
  var box = GetStorage();
  //
  RxString text = "".obs;
  //
  RxBool loads = true.obs;
  //
  List liste = [];
  //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$titre"),
        actions: const [
          /*IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          )*/
        ],
      ),
    );
  }
}
