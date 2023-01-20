import 'dart:async';
import 'dart:io';
import 'package:epst_app/vues/magasin/magasin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

class AttestationReussit extends GetView<MagasinController> {
  //
  AttestationReussit({this.titre}) {
    controller.getListeMag(4);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$titre"),
        actions: [
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
