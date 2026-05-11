import 'package:epst_app/vues/bibliotheques/pages/bibliotheque_classes_page.dart';
import 'package:flutter/material.dart';

class Bibliotheque extends StatelessWidget {
  final String propriete;

  const Bibliotheque({
    Key? key,
    this.propriete = 'Eleve',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BibliothequeClassesPage(propriete: propriete);
  }
}
