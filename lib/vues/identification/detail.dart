import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Map e;
  Details(this.e);
  @override
  State<StatefulWidget> createState() {
    return _Details();
  }
}

class _Details extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "${Connexion.lien}identification/piecejointe/${widget.e['id']}")),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
