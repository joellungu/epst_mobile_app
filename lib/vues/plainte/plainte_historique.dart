import 'package:epst_app/models/historiquedb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'details_plainte.dart';

class PlainteHis extends StatefulWidget {
  const PlainteHis({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlainteHis();
  }
}

class _PlainteHis extends State<PlainteHis> {
  Future<Widget> getPlaite() async {
    Historique historique = Historique();
    Database? db = await historique.openDB();
    //
    List<Map<String, dynamic>> listPlainte =
        await db.rawQuery('SELECT * FROM historique');

    return ListView(
      padding: const EdgeInsets.all(10),
      children: List.generate(
        listPlainte.length,
        (index) {
          print("['envoyer'] ${listPlainte[index]}");
          return Card(
            elevation: 1,
            child: InkWell(
              onTap: () {
                //
                Get.dialog(
                  Center(
                    child: Card(
                      elevation: 1,
                      child: Container(
                        height: 50,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text("${listPlainte[index]['reference']}"),
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 120,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "${listPlainte[index]["envoyer"]}, Votre plainte à été deposé avec succès, et sera traité dans le delais requis",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        onTap: () {
                          //
                          if (listPlainte[index]["envoyer"] == "non") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HistoriqueSend(listPlainte[index]);
                                },
                              ),
                            );
                          }
                        },
                        leading: const Icon(Icons.menu),
                        title: Text(listPlainte[index]["envoyeur"]),
                        subtitle: Text(listPlainte[index]["date"]),
                        trailing: listPlainte[index]["envoyer"] == "non"
                            ? const Icon(Icons.sync)
                            : const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
      ),
      body: FutureBuilder(
        future: getPlaite(),
        builder: (context, b) {
          if (b.hasData) {
            return b.data as Widget;
          } else if (b.hasError) {
            return Center(
              child: Text("Erreur lors du chargement: ${b.error}"),
            );
          }
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
