import 'package:epst_app/vues/formation/cursus/educ_de_base/educ_de_base_cours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Parcour extends StatelessWidget {
  //
  double? x, y;
  String? classe;
  double? pourcentage;
  Color? couleur;
  bool? active;
  //
  Parcour(
      {this.x,
      this.y,
      this.classe,
      this.pourcentage,
      this.couleur,
      this.active,
      Key? key})
      : super(key: key) {
    print("active: $active");
    print("classe: $classe");
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return InkWell(
      key: UniqueKey(),
      onTap: () {
        //
        if (active!) {
          print("active: $active");
          print("classe: $classe");
          Get.to(EducDeBaseCours("COURS DE LA $classe"));
        } else {
          print("active: $active");
          print("classe: $classe");
          Get.to(EducDeBaseCours("COURS DE LA $classe"));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Align(
          alignment: Alignment(x!, y!),
          child: Container(
            height: 70,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: couleur,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      classe!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: pourcentage != 0
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 30,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "$pourcentage %",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
