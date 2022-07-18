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
    WidgetsFlutterBinding.ensureInitialized();
  }
  //
  String? titre;
  var box = GetStorage();

  RxBool loads = true.obs;
  //
  List liste = [];
  //
  Future<void> loadMagasin() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      bool v = await Connexion.liste_magasin(1);
      //liste = await
      liste = box.read("magasin") ?? [];
      loads.value = v;
      if (v) {
        print("truc truc");
        liste = box.read("magasin") ?? [];
        loads.value = false;
        print("truc $liste");
        //
      }
    } else {
      liste = box.read("magasin") ?? [];
      loads.value = false;
    }

    //
    print("longueur  ___  $liste");
  }

  /*
  @override
  void initState() {
    //
    //loadMagasin();
    //
    super.initState();
  }
  */

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
            Timer(const Duration(seconds: 1), () async {
              //
              final Directory directory =
                  await getApplicationDocumentsDirectory();
              //load.value =
              await _spawnAndReceive("${state[index]['id']}",
                  state[index]['extention'], directory.path);
            });
            //Timer(const Duration(milliseconds: 500), () async {
            //});
            //
            return Obx(
              () => load.value == 0
                  ? Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      ),
                    )
                  : load.value == 2
                      ? Container()
                      : ListTile(
                          onTap: () async {
                            final Directory directory =
                                await getApplicationDocumentsDirectory();
                            //
                            //final File file = File('${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}');
                            //
                            print(
                                "${directory.path}/${state[index]["id"]}.${state[index]["extention"]}");
                            //
                            //File f = await File("${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}")
                            //  .writeAsBytes(box.read("${liste[index]["id"]}"));
                            //print(box.read("${liste[index]["id"]}"));

                            OpenResult or = await OpenFile.open(
                                "${directory.path}/${state[index]["id"]}.${state[index]["extention"]}");
                            print(or.message);
                            print(or.type);
                          },
                          leading: Icon(
                            Icons.file_copy_rounded,
                            color: Colors.black,
                          ),
                          title: Text(state[index]["libelle"]),
                          subtitle: Text(state[index]["date"]),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
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

  Future<void> _spawnAndReceive(
      String id, String extention, String path) async {
    //final p = ReceivePort();
    IsolatedWorker().run<List, void>((e) async {
      String id = e[0];
      String extention = e[1];
      String path = e[2];
      int result = 0;
      //
      //final Directory directory = await getApplicationDocumentsDirectory();
      //
      //print(':::$path/$id.$extention');
      //
      bool vc = await File('$path/$id.$extention').exists();
      //bool v = await Directory(
      //      '${directory.path}/${state[index]["id"]}.${state[index]["extention"]}')
      //.exists();
      //
      if (vc) {
        result = 1;
        print("Salut: 1");
      } else {
        MagasinController controller = Get.put(MagasinController());
        //result = await controller.write(id, extention);
        print("Salut: 2");
      }
      //return result;
    }, [extention, id, path]);
    //return (await p.first) as int;
  }

  Future<int> _readAndParseJson(List<String> args) async {
    //SendPort responsePort = args[0];
    String id = args[0];
    String extention = args[1];
    int result = 0;
    //
    //final Directory directory = await getApplicationDocumentsDirectory();
    //
    //print(':::${directory.path}/$id.$extention');
    //
    bool vc = true;
    //await File('${directory.path}/$id.$extention').exists();
    //bool v = await Directory(
    //      '${directory.path}/${state[index]["id"]}.${state[index]["extention"]}')
    //.exists();
    //
    if (vc) {
      result = 1;
      print("Salut: 1");
    } else {
      //load.value = 2;
      print("Salut: 2");
      //result = await controller.write(id, extention);
    }
    //final fileData = await File(fileName).readAsString();
    //final result = jsonDecode(fileData);
    //Isolate.exit(responsePort, result);
    return result;
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
