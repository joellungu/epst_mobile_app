import 'package:enseignement_en_ligne/pages/login/login.dart' as student;
import 'package:epst_app/vues/bibliotheques/bibliotheque.dart';
import 'package:flutter/material.dart';
import 'package:smart_keslassi_parent/pages/accueil.dart';

// ignore: must_be_immutable
class Formation extends StatefulWidget {
  String? titre;
  Formation({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Formation();
  }
}

class _Formation extends State<Formation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: const [
                Tab(text: 'Parcours scolaire'),
                Tab(text: 'Ma classe en ligne'),
                Tab(text: 'Bibliothèque'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  Accueil(),
                  const student.Login(embedded: true),
                  Bibliotheque(propriete: 'Eleve'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
