import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/recherche_annee.dart';
import 'package:epst_app/vues/ige/recherche_ecole.dart';
import 'package:epst_app/widgets/paiement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'demande_documents_formulaire.dart';
import 'demande_documents_simple.dart';
import 'document_certificatif_controller.dart';

class DemandeDocument extends StatefulWidget {
  String? titre;
  //
  DemandeDocument(this.titre, {Key? key}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _DemandeDocument();
  }
}

class _DemandeDocument extends State<DemandeDocument> {
  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.titre!,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Formulaire composé",
              ),
              Tab(
                text: "Formulaire simple",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeDocumentsFormulaire(widget.titre),
            DemandeDocumentsSimple(widget.titre),
          ],
        ),
      ),
    );
  }

  //
}
