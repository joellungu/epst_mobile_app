import 'package:epst_app/vues/depotplainte.dart';
import 'package:epst_app/vues/listing.dart';
import 'package:epst_app/vues/live.dart';
import 'package:epst_app/vues/magasine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  List listeIcons = [
    Icons.airplay,
    Icons.list_alt,
    Icons.dashboard,
    Icons.check_circle,
    Icons.people_alt_sharp,
    //CupertinoIcons.bubble_left_bubble_right_fill,
  ];

  List liste = [
    "Suivre RTEduc",
    "Depot plainte",
    "Mag EPST",
    "Actualité",
    "Listing",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EPST APP"),
        centerTitle: true,
        elevation: 1,
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: List.generate(liste.length, (index) {
          return ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                if (index == 0) {
                  return LiveStream(
                    titre: liste[index],
                  );
                } else if (index == 1) {
                  return DepotPlainte(
                    titre: liste[index],
                  );
                } else if (index == 2) {
                  return Magasine(
                    titre: liste[index],
                  );
                } else if (index == 3) {
                  return DepotPlainte(
                    titre: liste[index],
                  );
                } else if (index == 4) {
                  return Listing(
                    titre: liste[index],
                  );
                } else {
                  return Listing(
                    titre: liste[index],
                  );
                }
              }));
            },
            //elevation: 1,
            //color: Colors.white,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        listeIcons[index],
                        color: Colors.white70,
                        size: 100,
                      ),
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: index == 1 ? "MGP\n" : "",
                          children: [
                            TextSpan(
                              text: liste[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
