import 'dart:io';

import 'package:epst_app/utils/requetes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'vues/accueil.dart';

class PolitiqueConfidenciel extends StatelessWidget {
  //
  Requete requete = Requete();
  //
  late bool show;
  //
  PolitiqueConfidenciel(this.show);
  //
  var box = GetStorage();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: getPolitique(),
          builder: (c, t) {
            //
            if (t.hasData) {
              //print("hasData: ${t.data}");
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  HtmlWidget(t.data as String),
                ],
              );
            } else if (t.hasError) {
              //print("hasError: ${t.hasData}");
              return Container();
            }
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: show
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        //
                        box.write("lu", true);
                        Get.offAll(const Accueil());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text(
                        "Accepter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.dialog(
                          Center(
                            child: Card(
                              child: Container(
                                height: 200,
                                width: 200,
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Avertissement",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Pour utiliser l'application officiel de l'education nationel vous devez accepter cette politique de confidentialité.",
                                      textAlign: TextAlign.center,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //
                                        exit(0);
                                      },
                                      child: Text("Compris"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        "Réfuser",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 0,
              width: 0,
            ),
    );
  }

  //
  Future<String> getPolitique() async {
    //
    Response response = await requete.getE("educ-app/politique");
    if (response.isOk) {
      print("rep 1: ${response.statusCode}");
      //print("rep 1: ${response.body}");
      return response.body;
    } else {
      print("rep 2: ${response.statusCode}");
      //print("rep 2: ${response.body}");
      return "";
    }
  }
}
