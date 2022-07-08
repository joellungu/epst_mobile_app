import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Magasine extends StatefulWidget {
  String? titre;

  Magasine({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Magasine();
  }
}

class _Magasine extends State<Magasine> {
  //
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
    } else {
      liste = box.read("magasin") ?? [];
      loads.value = false;
    }

    //
    print("longueur  ___  $liste");
  }

  //
  @override
  void initState() {
    //
    loadMagasin();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: Obx(
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
    );
  }
}
