import 'package:epst_app/vues/actualite/clin_oeil.dart';
import 'package:epst_app/vues/actualite/site.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:flutter/material.dart';

class AccueilMag extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 4, // Nombre d'onglets pour chaque TabBar
      child: Scaffold(
        appBar: AppBar(
          title: Text("Magasin"),
          centerTitle: true,
        ),
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
                Tab(text: 'Actualité'),
                Tab(text: 'Magasin'),
                Tab(text: 'Emission'),
                Tab(text: 'Nouvelle citoyenneté'),
              ],
            ),
            const SizedBox(height: 10),
            // TabBarView pour le contenu
            Expanded(
              child: TabBarView(
                children: [
                  Actualites(),
                  Magasine(),
                  ClinOeil(),
                  Center(child: Text('Contenu Tab 3')),
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
