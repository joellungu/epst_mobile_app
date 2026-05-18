import 'package:epst_app/vues/sg/sg_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'details_sg.dart';

class SecretariaGeneral extends GetView<SgController> {
  //
  SecretariaGeneral({Key? key, this.titre}) : super(key: key) {
    controller.getAllSecretarial();
  }
  //
  final String? titre;
  final box = GetStorage();
  //
  final RxString text = "".obs;
  //
  final RxBool loads = true.obs;
  //
  final List liste = [];
  //
  String _text(Map data, List<String> keys, {String fallback = ''}) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return fallback;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("$titre"),
      //   actions: const [
      //     /*IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.search,
      //       ),
      //     )*/
      //   ],
      // ),
      body: controller.obx(
        (state) {
          List l = state!;
          return ListView(
            padding: const EdgeInsets.all(10),
            children: List.generate(
              l.length,
              (index) {
                Map s = l[index];
                final sigle = _text(s, ['sigle'], fallback: '-');
                final denomination = _text(
                  s,
                  ['denomination', 'denomition'],
                  fallback: 'Secretariat general',
                );
                return ListTile(
                  onTap: () async {
                    //
                    Get.dialog(
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 100,
                          width: 100,
                          child: const SizedBox(
                            height: 35,
                            width: 35,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                    //
                    Map e = await controller.getSecretarial("${s['id']}");
                    //
                    Get.back();
                    //
                    Get.to(DetailsSG(e));
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      sigle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(denomination),
                  //subtitle: const Text(
                  //  "Direction de l'information pour la gestion de l'éducation"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
          );
        },
        onEmpty: Container(),
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      // body: controller.obx(
      //   (List<dynamic>? stat) {
      //     if (stat != null) {
      //       print(stat);
      //       RxList l = RxList(stat);
      //       print(l);
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           SizedBox(
      //             height: 5,
      //           ),
      //           Container(
      //             padding: EdgeInsets.only(
      //               left: 15,
      //               right: 15,
      //             ),
      //             height: 45,
      //             child: TextField(
      //               textInputAction: TextInputAction.search,
      //               onChanged: (t) {
      //                 //
      //                 text.value = t;
      //               },
      //               decoration: InputDecoration(
      //                 prefixIcon: Icon(Icons.search),
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(5),
      //                   borderSide: BorderSide(
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             flex: 1,
      //             child: Obx(
      //               () => ListView(
      //                 children: List.generate(l.length, (index) {
      //                   //
      //                   RxInt load = 0.obs;
      //                   Timer(const Duration(milliseconds: 1), () async {
      //                     //
      //                     final Directory directory =
      //                         await getApplicationDocumentsDirectory();
      //                     String path = directory.path;
      //                     load.value = await File(
      //                                 '$path/${l[index]['id']}.${l[index]['extention']}')
      //                             .exists()
      //                         ? 1
      //                         : 0;
      //                     //_spawnAndReceive("${state[index]['id']}",
      //                     //state[index]['extention'], directory.path);
      //                   });
      //                   //Timer(const Duration(milliseconds: 500), () async {
      //                   //});
      //                   print("${l[index]["libelle"]}"
      //                       .toLowerCase()
      //                       .contains(text.value.toLowerCase()));
      //                   //
      //                   return "${l[index]["libelle"]}"
      //                           .toLowerCase()
      //                           .contains(text.value.toLowerCase())
      //                       ? Obx(
      //                           () => ListTile(
      //                             onTap: () async {
      //                               if (load.value == 1) {
      //                                 final Directory directory =
      //                                     await getApplicationDocumentsDirectory();
      //                                 print(
      //                                     "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
      //                                 OpenResult or = await OpenFile.open(
      //                                     "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
      //                                 print(or.message);
      //                                 print(or.type);
      //                                 //Get.to(PdfVue(
      //                                 //  "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}"));
      //                               } else {
      //                                 load.value = 2;
      //                                 //
      //                                 load.value = await controller.write(
      //                                     "${l[index]["id"]}",
      //                                     "${l[index]["extention"]}");
      //                                 print("lecture: ${load.value}");
      //                               }
      //                             },
      //                             leading: Image.asset(
      //                               "assets/logo-app.jpeg",
      //                               color: Colors.blue,
      //                               colorBlendMode: BlendMode.color,
      //                             ),
      //                             title: Text(l[index]["libelle"]),
      //                             subtitle: Text(l[index]["dateenligne"]),
      //                             trailing: load.value == 1
      //                                 ? const Icon(
      //                                     Icons.check_circle_outline,
      //                                     color: Colors.green,
      //                                   )
      //                                 : load.value == 0
      //                                     ? const Icon(
      //                                         Icons.download,
      //                                         color: Colors.black,
      //                                       )
      //                                     : Container(
      //                                         height: 40,
      //                                         width: 40,
      //                                         alignment: Alignment.center,
      //                                         child:
      //                                             const CircularProgressIndicator(),
      //                                       ),
      //                           ),
      //                         )
      //                       : Container();
      //                 }),
      //               ),
      //             ),
      //           )
      //         ],
      //       );
      //     } else {
      //       return Container(
      //         child: Text(""),
      //       );
      //     }
      //   },
      //   // here you can put your custom loading indicator, but
      //   // by default would be Center(child:CircularProgressIndicator())
      //   onLoading: Shimmer.fromColors(
      //     baseColor: Colors.grey.shade200,
      //     highlightColor: Colors.grey.shade400,
      //     child: ListView(
      //       children: List.generate(
      //         10,
      //         (index) => ListTile(
      //           leading: Container(
      //             height: 50,
      //             width: 50,
      //             decoration: BoxDecoration(
      //               color: Colors.grey,
      //               borderRadius: BorderRadius.circular(25),
      //             ),
      //           ),
      //           title: Container(
      //             height: 10,
      //             width: 200,
      //             color: Colors.grey,
      //           ),
      //           subtitle: Container(
      //             height: 10,
      //             width: 100,
      //             color: Colors.grey,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   onEmpty: const Center(
      //     child: Text(
      //       'Vide',
      //       style: TextStyle(
      //         color: Colors.grey,
      //         fontSize: 13,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      //   // here also you can set your own error widget, but by
      //   // default will be an Center(child:Text(error))
      //   onError: (error) => Text("$error"),
      // ),
    );
  }
}
