import 'package:flutter/material.dart';

class Esige extends StatelessWidget {
  String? titre;
  Esige({this.titre});
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(titre!),
      ),
    );
  }
}
