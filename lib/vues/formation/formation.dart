import 'package:enseignement_en_ligne/pages/login/login.dart' as student;
import 'package:epst_app/vues/bibliotheques/bibliotheque.dart';
import 'package:epst_app/vues/parcours_scolaire/espace_parent.dart';
import 'package:flutter/material.dart';

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
                Tab(icon: Icon(Icons.timeline_outlined, size: 20), text: 'Parcours scolaire'),
                Tab(icon: Icon(Icons.videocam_outlined, size: 20), text: 'Ma classe en ligne'),
                Tab(icon: Icon(Icons.library_books_outlined, size: 20), text: 'Bibliothèque'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  EspaceParent(),
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
