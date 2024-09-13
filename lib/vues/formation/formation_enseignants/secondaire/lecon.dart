import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LeconSecondaire extends StatelessWidget {
  String lecon;
  LeconSecondaire(this.lecon, {Key? key}) : super(key: key);
  //
  Rx<Widget> vue = Rx<Widget>(
    Container(
      height: 40,
      width: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: const Text("..."),
    ),
  );
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(lecon),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              //Animation - 1719838060757.json
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                // child: Image.asset(
                //   "assets/LOGO-MINEPST-BON.png",
                //   color: Colors.blue,
                //   colorBlendMode: BlendMode.color,
                // ), //
                decoration: const BoxDecoration(
                  //color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Lottie.asset('assets/Animation - 1719838060757.json'),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Remplacer les pointiels par le mot correspondant",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Maman et Papa ",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    children: [
                      WidgetSpan(
                        child: DragTarget(
                          builder: (c, a, r) {
                            //Animation - 1719838039108.json
                            return Obx(() => vue.value);
                          },
                          onAcceptWithDetails:
                              (DragTargetDetails<String> reponse) {
                            print("Arrivé: ${reponse.data}");
                            if (reponse.data == "sont") {
                              Timer(
                                const Duration(microseconds: 500),
                                () {
                                  Get.dialog(
                                    Center(
                                      child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: Lottie.asset(
                                            'assets/Animation - 1719838039108.json'),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Timer(
                                const Duration(microseconds: 500),
                                () {
                                  Get.dialog(
                                    Center(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: SizedBox(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 9,
                                                child: SizedBox(
                                                  height: 200,
                                                  width: 200,
                                                  child: Lottie.asset(
                                                      'assets/Animation - 1720104239176.json'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Align(
                                                alignment: Alignment.center,
                                                child: Card(
                                                  color: Colors.transparent,
                                                  child: Text(
                                                    "Erreur mauvaise reponse",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            vue.value = Container(
                              height: 40,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(reponse.data),
                            );
                          },
                        ),
                      ),
                      const TextSpan(
                        text: " à l'Ecole.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 100,
                //color: Colors.green,
                child: Wrap(
                  direction: Axis.vertical,
                  runSpacing: 10,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Draggable(
                        data: "sans",
                        feedback: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Card(
                              elevation: 0,
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: const Center(
                                  child: Text(
                                    'sans',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onDraggableCanceled: (_, __) {
                          print('Glissement annulé');
                        },
                        child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'sans',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Draggable(
                        data: "son",
                        feedback: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Card(
                              elevation: 0,
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: const Center(
                                  child: Text(
                                    'son',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onDraggableCanceled: (_, __) {
                          print('Glissement annulé');
                        },
                        child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'son',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Draggable(
                        data: "sont",
                        feedback: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Card(
                              elevation: 0,
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: const Center(
                                  child: Text(
                                    'sont',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onDraggableCanceled: (_, __) {
                          print('Glissement annulé');
                        },
                        child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'sont',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
