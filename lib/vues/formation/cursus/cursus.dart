import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'educ_de_base/educ_de_base.dart';
import 'login/login_enseignant/infos_personnel.dart';
import 'secondaire/secondaire.dart';

class Cursus extends StatelessWidget {
  RxString titre = "".obs;

  Cursus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        reverse: true,
        children: [
          const EducDeBase(),
          Container(
            height: 30,
            width: Get.size.width,
            color: Colors.teal.shade700,
            alignment: Alignment.center,
            child: Obx(
              () => Text(
                "TENAFEPP / $titre",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Secondaire(),
          Container(
            height: 30,
            width: Get.size.width,
            color: Colors.teal.shade700,
            alignment: Alignment.center,
            child: Obx(
              () => Text(
                "EXAMENT D'ETAT / $titre",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: Get.size.height / 1.3,
            width: Get.size.width,
            color: Colors.green.shade200,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              barrierLabel: "Profil utilisateur",
              //barrierColor: Colors.black,
              showDragHandle: true,
              builder: (context) {
                return Container(
                  width: Get.size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          children: [
                            InkWell(
                              onTap: () {
                                //
                                Get.back();
                                titre.value = "Joel Lungu";
                              },
                              child: Container(
                                height: 65,
                                width: 130,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade100
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text("Joel Lungu"),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //
                          Get.back();
                          //
                          Get.to(InfosPersonnel(const {}));
                          // Get.dialog(
                          //   Center(
                          //     child: Card(
                          //       child: Container(
                          //         height: 170,
                          //         width: Get.size.width / 1.5,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         child: Column(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceAround,
                          //           children: [
                          //             Align(
                          //               alignment: Alignment.topCenter,
                          //               child: Text(
                          //                 "Nouveau profil",
                          //                 style: TextStyle(
                          //                   fontWeight: FontWeight.w900,
                          //                   fontSize: 15,
                          //                   color: Colors.grey.shade700,
                          //                 ),
                          //               ),
                          //             ),
                          //             ElevatedButton(
                          //               onPressed: () {
                          //                 Get.back();
                          //                 Get.to(LoginEnseignant());
                          //               },
                          //               style: ButtonStyle(
                          //                 backgroundColor:
                          //                     WidgetStateProperty.all(
                          //                         Colors.blue),
                          //                 textStyle: WidgetStateProperty.all(
                          //                   TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: 13,
                          //                   ),
                          //                 ),
                          //               ),
                          //               child: const Text(
                          //                 "Enseignant",
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //             ),
                          //             //
                          //             ElevatedButton(
                          //               onPressed: () {
                          //                 Get.back();
                          //                 //
                          //               },
                          //               style: ButtonStyle(
                          //                 backgroundColor:
                          //                     WidgetStateProperty.all(
                          //                         Colors.blue),
                          //                 textStyle: WidgetStateProperty.all(
                          //                   TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: 13,
                          //                   ),
                          //                 ),
                          //               ),
                          //               child: const Text(
                          //                 "Elève",
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                          textStyle: WidgetStateProperty.all(
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Ajouter",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: SvgPicture.asset(
          "assets/UiwUser.svg",
          semanticsLabel: 'Acme Logo',
          color: Colors.black,
        ),
      ),
    );
  }
}
