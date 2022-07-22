import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isolated_worker/isolated_worker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:isolate';

import 'magasin_controller.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
/*
class Magasinee extends StatefulWidget {
  String? titre;

  Magasinee({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Magasine();
  }
}
*/

class Magasine extends GetView<MagasinController> {
  //
  Magasine({this.titre}) {
    controller.getListeMag(1);
  }
  //
  String? titre;
  var box = GetStorage();

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
      body: controller.obx(
        (state) => ListView(
          children: List.generate(state!.length, (index) {
            //
            //
            RxInt load = 0.obs;
            Timer(const Duration(milliseconds: 1), () async {
              //
              final Directory directory =
                  await getApplicationDocumentsDirectory();
              String path = directory.path;
              load.value = await File(
                          '$path/${state[index]['id']}.${state[index]['extention']}')
                      .exists()
                  ? 1
                  : 0;
              //_spawnAndReceive("${state[index]['id']}",
              //state[index]['extention'], directory.path);
            });
            //Timer(const Duration(milliseconds: 500), () async {
            //});
            //
            return Obx(
              () => ListTile(
                onTap: () async {
                  if (load.value == 1) {
                    final Directory directory =
                        await getApplicationDocumentsDirectory();
                    print(
                        "${directory.path}/${state[index]["id"]}.${state[index]["extention"]}");
                    OpenResult or = await OpenFile.open(
                        "${directory.path}/${state[index]["id"]}.${state[index]["extention"]}");
                    print(or.message);
                    print(or.type);
                  } else {
                    load.value = 2;
                    //
                    load.value = await controller.write("${state[index]["id"]}",
                        "${state[index]["extention"]}");
                    print("lecture");
                  }
                },
                leading: Icon(
                  Icons.file_copy_rounded,
                  color: Colors.black,
                ),
                title: Text(state[index]["libelle"]),
                subtitle: Text(state[index]["date"]),
                trailing: load.value == 1
                    ? const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : load.value == 0
                        ? const Icon(
                            Icons.download,
                            color: Colors.black,
                          )
                        : Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
              ),
            );
          }),
        ),
        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade400,
          child: ListView(
            children: List.generate(
              10,
              (index) => ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                title: Container(
                  height: 10,
                  width: 200,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        onEmpty: const Center(
          child: Text(
            'Vide',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => Text("$error"),
      ),
    );
  }
}

/*
Obx(
        () => loads.value
            ? Center(
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                children: List.generate(liste.length, (index) {
                  return ListTile(
                    onTap: () async {
                      final Directory directory =
                          await getApplicationDocumentsDirectory();
                      //
                      //final File file = File('${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}');
                      //
                      print(
                          "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
                      //
                      //File f = await File("${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}")
                      //  .writeAsBytes(box.read("${liste[index]["id"]}"));
                      //print(box.read("${liste[index]["id"]}"));

                      OpenResult or = await OpenFile.open(
                          "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
                      print(or.message);
                      print(or.type);
                    },
                    leading: Icon(
                      Icons.file_copy_rounded,
                      color: Colors.black,
                    ),
                    title: Text(liste[index]["libelle"]),
                    subtitle: Text(liste[index]["date"]),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                  );
                }),
              ),
      ),
*/
