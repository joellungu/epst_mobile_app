import 'dart:async';
import 'dart:convert';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  Future<Widget> loadMagasin() async {
    List<Map<String, dynamic>> liste = await Connexion.liste_magasin(1);
    print("longueur  ___  $liste");
    return ListView(
      children: List.generate(liste.length, (index) {
        return ListTile(
          onTap: () {
            //OpenFile.open("/sdcard/example.txt");
          },
          leading: Icon(
            Icons.file_copy,
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
            return Center(
              child: Text("Problème de connexion"),
            );
          }
          return Center(
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
