import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/magasin.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
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
  //
  Future<Widget> loadMagasin() async {
    List<Map<String, dynamic>> liste = [];
    //

    //
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      liste = await Connexion.liste_magasin(1);
    } else {
      Magasin magasin = Magasin();
      //
      Database db = await magasin.openDB();
      //
      liste = await db.query("magasin");
    }
    print("longueur  ___  $liste");
    return ListView(
      children: List.generate(liste.length, (index) {
        return ListTile(
          onTap: () async {
            final Directory directory =
                await getApplicationDocumentsDirectory();
            //
            print(
                "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
            //
            File f = await File("${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}")
            .writeAsBytes(box.read("${liste[index]["id"]}"));
            print(box.read("${liste[index]["id"]}"));

            OpenResult or = await OpenFile.open(
                "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
            print(or.message);
            print(or.type);
          },
          leading: Icon(
            Icons.folder,
            color: Colors.black,
          ),
          title: Text(liste[index]["libelle"]),
          subtitle: Text(liste[index]["date"]),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
        );
      }),
    );
  }
  //

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
      body: FutureBuilder(
        future: loadMagasin(),
        builder: (context, t) {
          if (t.hasData) {
            return t.data as Widget;
          } else if (t.hasError) {
            return const Center(
              child: Text("Problème de connexion"),
            );
          }
          return Center(
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: const LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
