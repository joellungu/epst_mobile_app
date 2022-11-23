import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';

class Transfere1 extends StatefulWidget {
  Map<String, dynamic>? utilisateur;
  List<Map<String, dynamic>> listeFichier = [];
  //
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
    print("______________:   $rep");
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
              if (widget.listeFichier.length != 0) {
                return Transfere2(
                    "${json.decode("${snapshot.data}")}", widget.listeFichier);
              } else {
                return Center(
                  child: Text("Plainte envoyé!"),
                );
              }
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
  int t = 0;
  bool mx = true;
  Future<void> send() async {
    //String rep = await Connexion.enregistrementPiecejointe(
    //widget.piecejointeId, widget.listeFichier);
    widget.listeFichier.forEach(
      (element) async {
        //https://epstapp.herokuapp.com
        var url = Uri.parse(
            "${Connexion.lien}piecejointe/${widget.piecejointeId}/${element["type"]}");
        //element ;
        //var stream = new http.ByteStream(DelegatingStream.typed(element["type"]));
        var length = await element["length"];
        print("------------------------");
        print(element["type"]);
        print(widget.piecejointeId);
        print("------------------------");

        Map<String, dynamic> map = {
          "piecejointe_id": widget.piecejointeId,
          "donne": element["data"],
          "type": element["type"]
        };
        var response = await http.post(
          url,
          headers: {
            "Content-Type": "multipart/form-data", //"application/json",
          },
          body: element["data"],
        );
        //
        if (response.statusCode == 201 || response.statusCode == 200) {
          setState(() {
            t++;
          });
        }
        //
        print("_____________: ${response.body}");
        print("_____________: ${response.headers}");
        print("_____________: ${response.statusCode}");
        print("_____________: ${response.contentLength}");
      },
    );
    Timer(Duration(seconds: 1), () {
      setState(() {
        mx = false;
      });
    });
    //return rep;
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
  void initState() {
    //
    send();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mx
              ? Card(
                  elevation: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Card(
                  elevation: 1,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
                ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
                "Nombre d'element envoyé : $t sur un total de : ${widget.listeFichier.length}"),
          ),
        ],
      ),
    );
  }
}
