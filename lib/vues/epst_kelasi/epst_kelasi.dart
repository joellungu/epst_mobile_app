import 'package:flutter/material.dart';

class EpstKelasi extends StatefulWidget {
  String titre;
  EpstKelasi(this.titre, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EpstKelasi();
  }
}

class _EpstKelasi extends State<EpstKelasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titre),
      ),
    );
  }
}
