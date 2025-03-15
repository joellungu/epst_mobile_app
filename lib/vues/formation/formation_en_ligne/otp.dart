import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Otp extends StatelessWidget {
  //
  TextEditingController userName = TextEditingController();
  //
  TextEditingController password = TextEditingController();
  //
  RxString showPassword = "HugeiconsView".obs;
  //
  RxInt t = 120.obs;
  //
  Otp() {
    //
    Timer.periodic(const Duration(seconds: 1), (r) {
      //
      t.value = t.value - 1;
    });
  }
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  //child: SvgPicture.asset("assets/SolarUserRoundedLinear.svg"),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage("assets/img_3.jpg")),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Entrez l'OTP",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Un code à 4 chiffres a été envoyé à l'adresse mail ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                      children: [
                        WidgetSpan(
                          child: Text(
                            "lungujoel138@gmail.com",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Pinput(onCompleted: (pin) {
                //   //
                //   Get.to(Reset());
                // }),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      "Temps restant: ${t.value} s",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     elevation: 0,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     fixedSize: Size(Get.size.width, 48),
                //     backgroundColor: Couleurs.couleurBleu,
                //   ),
                //   onPressed: () async {
                //     //Vendor
                //     //Get.offAll(Verificationotp());
                //     //Get.offAll(Vendor());
                //     if (userName.text.isEmpty || password.text.isEmpty) {
                //       //
                //       Get.snackbar("Oups", "Veuillez saisir tout les champs.");
                //     } else {
                //       //
                //       // Loader.load();
                //       // //
                //       // Map user = {
                //       //   "username": userName.text,
                //       //   "password": password.text,
                //       // };
                //       // //

                //       // //String username, String password
                //       // loginController.getLogin(user);
                //     }
                //   },
                //   child: const Text(
                //     "Soumettre",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
}
