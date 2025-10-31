import 'package:enseignement_en_ligne/enseignement_en_ligne.dart';
import 'package:epst_app/vues/enseignants/bibliotheque_enseignant.dart';
import 'package:epst_app/vues/formation/foad.dart';
import 'package:epst_app/vues/ige/ige.dart';
import 'package:flutter/material.dart';
import 'package:professeurs_app/pages/login/connexion.dart';

class AccueilEnseignant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _AccueilEnseignant();
  }
}

class _AccueilEnseignant extends State<AccueilEnseignant> {
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
                Tab(text: 'Gestion Classe'),
                Tab(text: 'Formation en ligne Ens.'),
                Tab(text: 'Bibliothèque'),
              ],
            ),
            const SizedBox(height: 10),
            // TabBarView pour le contenu
            Expanded(
              child: TabBarView(
                children: [
                  LoginScreen(),
                  Login(),
                  // FOAD(),
                  BibliothequeEnseignant()
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
