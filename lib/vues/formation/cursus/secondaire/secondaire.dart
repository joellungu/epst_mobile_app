import 'package:epst_app/widgets/evolution_widget.dart';
import 'package:epst_app/widgets/parcour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Secondaire extends StatelessWidget {
  const Secondaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: Get.size.height / 2,
      width: Get.size.width,
      color: Colors.white,
      //.shade200.withOpacity(0.2),
      child: Stack(
        children: [
          Container(
            height: Get.size.height / 2,
            width: Get.size.width,
            alignment: Alignment.center,
            child: Text(
              "LES CLASSES DE SECONDES",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade100.withOpacity(0.2),
              ),
            ),
          ),
          //La pas
          EvolutionWidget(100, 100, 140, 0.2, 0.50), //Premier pas
          EvolutionWidget(230, 100, 25, -0.45, 0.25), //Deuxieme
          EvolutionWidget(130, 100, 150, -0.70, -1), //Troisieme
          //
          Parcour(
              x: 0,
              y: 1,
              classe: "1",
              pourcentage: 60,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0.75,
              y: 0.3,
              classe: "2",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: -0.95,
              y: -0.5,
              classe: "3",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0,
              y: -1,
              classe: "4",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
        ],
      ),
    );
  }
}
