import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';

class Transfere1 extends StatefulWidget {
  Map<String, dynamic>? utilisateur;
  List<Map<String, dynamic>> listeFichier = [];
  Transfere1(this.utilisateur, this.listeFichier);
  //
  @override
  State<StatefulWidget> createState() {
    return _Transfere1();
  }
}

class _Transfere1 extends State<Transfere1> {
  Future<String> send() async {
    String rep = await Connexion.enregistrement(widget.utilisateur!);

    return rep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: send(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "0") {
              return Transfere2("${json.decode("${snapshot.data}")["save"]}",
                  widget.listeFichier);
            } else {
              return Center(
                child:
                    Text("La plainte n'a pas été déposé! erreur au serveur."),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Un probleme est survenu lors de l'envois de la plainte\ncode: ${snapshot.error}"),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Envois de votre plainte en cours..."),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Transfere2 extends StatefulWidget {
  String piecejointeId;
  List<Map<String, dynamic>> listeFichier = [];
  Transfere2(this.piecejointeId, this.listeFichier);
  //
  @override
  State<StatefulWidget> createState() {
    return _Transfere2();
  }
}

class _Transfere2 extends State<Transfere2> {
  Future<String> send() async {
    String rep = await Connexion.enregistrementPiecejointe(
        widget.piecejointeId, widget.listeFichier);

    return rep;
  }

  Widget message(String message) {
    Timer(Duration(seconds: 5), () {
      //
      Navigator.of(context).pop();
    });
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text("$message"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: send(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return message("Truc");
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                "Un probleme est survenu lors de l'envois de la plainte\ncode: ${snapshot.error}"),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text("Envois de votre plainte en cours..."),
            ),
          ],
        );
      },
    ));
  }
}
