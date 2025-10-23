import 'package:epst_app/vues/ige/ige.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:flutter/material.dart';

class AccueilSg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _AccueilSg();
  }
}

class _AccueilSg extends State<AccueilSg> {
  //
  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 3, // Nombre d'onglets pour chaque TabBar
      child: Scaffold(
        body: Column(
          children: [
            // TabBar 1
            TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelStyle: TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(text: 'Secretariat général'),
                Tab(text: 'Statistiques'),
                Tab(text: 'Documents admin'),
              ],
            ),
            const SizedBox(height: 10),
            // TabBarView pour le contenu
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Contenu Tab 1')),
                  Center(child: Text('Contenu Tab 2')),
                  Magasine(
                    type: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
}
