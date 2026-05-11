import 'package:epst_app/vues/bibliotheques/bibliotheque.dart';
import 'package:flutter/material.dart';

class BibliothequeEnseignant extends StatelessWidget {
  const BibliothequeEnseignant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Bibliotheque(propriete: 'Professeur');
  }
}
