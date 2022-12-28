import 'dart:async';
import 'dart:io';
import 'package:epst_app/vues/magasin/magasin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

class ArretesMinisteriel extends GetView<MagasinController> {
  //
  ArretesMinisteriel({this.titre}) {
    controller.getListeMag(3);
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
      body: controller.obx(
        (List<dynamic>? stat) {
          if (stat != null) {
            print(stat);
            RxList l = RxList(stat);
            print(l);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  height: 45,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onChanged: (t) {
                      //
                      text.value = t;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => ListView(
                      children: List.generate(l.length, (index) {
                        //
                        RxInt load = 0.obs;
                        Timer(const Duration(milliseconds: 1), () async {
                          //
                          final Directory directory =
                              await getApplicationDocumentsDirectory();
                          String path = directory.path;
                          load.value = await File(
                                      '$path/${l[index]['id']}.${l[index]['extention']}')
                                  .exists()
                              ? 1
                              : 0;
                          //_spawnAndReceive("${state[index]['id']}",
                          //state[index]['extention'], directory.path);
                        });
                        //Timer(const Duration(milliseconds: 500), () async {
                        //});
                        print("${l[index]["libelle"]}"
                            .toLowerCase()
                            .contains(text.value.toLowerCase()));
                        //
                        return "${l[index]["libelle"]}"
                                .toLowerCase()
                                .contains(text.value.toLowerCase())
                            ? Obx(
                                () => ListTile(
                                  onTap: () async {
                                    if (load.value == 1) {
                                      final Directory directory =
                                          await getApplicationDocumentsDirectory();
                                      print(
                                          "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
                                      OpenResult or = await OpenFile.open(
                                          "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
                                      print(or.message);
                                      print(or.type);
                                    } else {
                                      load.value = 2;
                                      //
                                      load.value = await controller.write(
                                          "${l[index]["id"]}",
                                          "${l[index]["extention"]}");
                                      print("lecture: ${load.value}");
                                    }
                                  },
                                  leading: Image.asset(
                                    "assets/logo-app.jpeg",
                                    color: Colors.blue,
                                    colorBlendMode: BlendMode.color,
                                  ),
                                  title: Text(l[index]["libelle"]),
                                  subtitle: Text(l[index]["date"]),
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
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                ),
                              )
                            : Container();
                      }),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container(
              child: Text(""),
            );
          }
        },
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
