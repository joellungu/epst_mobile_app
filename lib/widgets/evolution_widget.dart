import 'package:flutter/material.dart';

import 'evolution.dart';

class EvolutionWidget extends StatelessWidget {
  double largeur = 100, hauteur = 100, d = 0;
  double x, y;
  EvolutionWidget(this.largeur, this.hauteur, this.d, this.x, this.y);
  //
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.all(3),
        child:   Align(
          alignment: Alignment(x, y),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(d / 360),
            child: CustomPaint(
              size: Size(largeur, hauteur),
              painter: Evolution(0, 0),
            ),
          ),
        )
    );
  }

}