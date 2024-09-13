import 'package:epst_app/widgets/evolution_widget.dart';
import 'package:epst_app/widgets/parcour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducDeBase extends StatelessWidget {
  const EducDeBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: Get.size.height / 1.3,
      width: Get.size.width,
      color: Colors.white,
      //.shade200.withOpacity(0.2),
      child: Stack(
        children: [
          Container(
            height: Get.size.height / 1.3,
            width: Get.size.width,
            alignment: Alignment.center,
            child: Text(
              "EDUCATION DE BASE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade100.withOpacity(0.2),
              ),
            ),
          ),
          //La pas
          EvolutionWidget(100, 100, 140, 0.2, 0.80), //Premier pas
          EvolutionWidget(200, 100, 10, -0.2, 0.85), //Deuxieme
          EvolutionWidget(130, 100, 155, -0.55, 0.25), //Troisieme
          EvolutionWidget(100, 100, 120, 0.4, -0.15), //Quatrieme
          EvolutionWidget(200, 100, 13, 0.15, -0.20), //Cienquieme
          EvolutionWidget(200, 100, 160, 0.15, -0.85), //Sizieme
          EvolutionWidget(100, 100, 20, 0.4, -0.75), //Septième
          //
          Parcour(
              x: 0,
              y: 1,
              classe: "1",
              pourcentage: 60,
              couleur: Colors.blue,
              active: true,
              key: UniqueKey()),
          Parcour(
              x: 0.75,
              y: 0.70,
              classe: "2",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: -0.95,
              y: 0.5,
              classe: "3",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0.3,
              y: 0.25,
              classe: "4",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0.8,
              y: -0.25,
              classe: "5",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: -0.7,
              y: -0.5,
              classe: "6",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0.95,
              y: -0.75,
              classe: "7",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
          Parcour(
              x: 0,
              y: -1,
              classe: "8",
              pourcentage: 0,
              couleur: Colors.grey,
              active: false,
              key: UniqueKey()),
        ],
      ),
    );
  }
  //
}
