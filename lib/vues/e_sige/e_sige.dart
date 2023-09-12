import 'package:flutter/material.dart';

class Esige extends StatelessWidget {
  String? titre;
  Esige({Key? key, this.titre}) : super(key: key);
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
