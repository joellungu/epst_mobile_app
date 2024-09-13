import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:percent_indicator/percent_indicator.dart';

final dio = Dio();

class Transfere1 extends StatefulWidget {
  Map<String, dynamic>? utilisateur;
  List<Map<String, dynamic>> listeFichier = [];
  //
  Transfere1(this.utilisateur, this.listeFichier, {Key? key}) : super(key: key);
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
              if (widget.listeFichier.isNotEmpty) {
                return Transfere2(
                    "${json.decode("${snapshot.data}")}", widget.listeFichier);
              } else {
                return const Center(
                  child: Text("Plainte envoyé!"),
                );
              }
            } else {
              return const Center(
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
                child: const CircularProgressIndicator(),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text("Envois de votre plainte en cours..."),
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
  Transfere2(this.piecejointeId, this.listeFichier, {Key? key})
      : super(key: key);
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
        //element ; ${widget.piecejointeId}/${element["type"]}
        //var stream = new http.ByteStream(DelegatingStream.typed(element["type"]));
        var length = await element["length"];
        print("------------------------");
        print(element["type"]);
        print(widget.piecejointeId);
        print("------------------------");
        /*
        Map<String, dynamic> map = {
          "piecejointe_id": widget.piecejointeId,
          "donne": element["data"],
          "type": element["type"]
        };
        */

        //

        // var res = await request.send();
        // if (res.statusCode == 201 || res.statusCode == 200) {
        //   print(res.statusCode);
        //   print("cool");
        //   print("cool: rep: ${res.headers}");
        //   print("cool: rep: ${res.stream}");
        // } else {
        //   print(res.statusCode);
        //   print("pas cool");
        //   print("cool: rep: ${res.headers}");
        //   print("cool: rep: ${res.stream}");
        // }

        ///
        var response = await http.post(url,
            headers: {
              "Content-Type":
                  "application/octet-stream" //"application/json", //"multipart/form-data", //
            },
            body: element["data"] //jsonEncode(map),
            //element["data"],
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
    Timer(const Duration(seconds: 1), () {
      setState(() {
        mx = false;
      });
    });
    //return rep;
  }

  Widget message(String message) {
    Timer(const Duration(seconds: 5), () {
      //
      Navigator.of(context).pop();
    });
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(message),
    );
  }

  @override
  void initState() {
    //
    //send();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Envois piece jointe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Card(
            elevation: 1,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 70,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: List.generate(
                widget.listeFichier.length,
                (index) => ProgressionIndication(
                  widget.listeFichier[index],
                  widget.piecejointeId,
                ),
              ),
            ),
          ),
          // Container(
          //   height: 40,
          //   alignment: Alignment.center,
          //   child: Text(
          //       "Nombre d'element envoyé : $t sur un total de : ${widget.listeFichier.length}"),
          // ),
        ],
      ),
    );
  }
}

class ProgressionIndication extends StatefulWidget {
  Map? e;
  String piecejointeId;
  ProgressionIndication(this.e, this.piecejointeId, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    //
    return _ProgressionIndication();
  }
}

class _ProgressionIndication extends State<ProgressionIndication> {
  //
  String percentage = "";
  double pr = 0.0;
  //

  send() async {
    var res = await dio.post(
      "${Connexion.lien}piecejointe/${widget.piecejointeId}/${widget.e!["type"]}",
      data: widget.e!["data"],
      onSendProgress: (int sent, int total) {
        percentage = (sent / total * 100).toStringAsFixed(2);
        pr = double.parse(percentage);
        print("::::::::: $percentage ");
        setState(() {
          /*
              progress = "$sent" +
                  " Bytes of " "$total Bytes - " +
                  percentage +
                  " % uploaded";
                  */
          print(
              "::::::::: $sent Bytes of $total Bytes - $percentage % uploaded");
          //update the progress
        });
      },
    );

    if (res.statusCode == 200) {
      print(res.toString());
      //print response from server
    } else {
      print("Error during connection to server.");
    }
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "${widget.e!['name']}.${widget.e!['type']}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(5),
          height: 35,
          width: double.maxFinite,
          child: LinearPercentIndicator(
            width: 300,
            lineHeight: 20.0,
            percent: pr / 100,
            center: Text(
              "$pr %",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.grey.shade400,
            progressColor: Colors.blue.shade700,
          ),
        )
      ],
    );
  }
}
