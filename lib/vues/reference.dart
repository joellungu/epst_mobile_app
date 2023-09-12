import 'package:epst_app/models/historiquedb.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class References extends StatefulWidget {
  const References({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _References();
  }
}

class _References extends State<References> {
  Future<Widget> getReferences() async {
    Historique h = Historique();
    Database db = await h.openDB();

    List<Map<String, dynamic>> liste = await db.query("historique");

    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (context, t) {
        return ListTile(
          onTap: () {
            //
          },
          title: Text(liste[t]["date"]),
          subtitle: Text(liste[t]["reference"]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("References"),
      ),
      body: FutureBuilder(
        future: getReferences(),
        builder: (context, sn) {
          if (sn.hasData) {
            return sn.data as Widget;
          } else if (sn.hasError) {
            return Container();
          }
          //
          return Center(
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

/*

*/