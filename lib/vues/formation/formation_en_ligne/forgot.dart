import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'otp.dart';
import 'reset.dart';

class Forgot extends StatelessWidget {
  //
  TextEditingController userName = TextEditingController();
  //
  TextEditingController password = TextEditingController();
  //
  RxString showPassword = "HugeiconsView".obs;
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
                        image: ExactAssetImage("assets/LOGO-MINEPST-BON.png")),
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
                    "Mot de passe oublié ?",
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
                  child: Text(
                    "Ne vous inquiètez pas, veuillez s'il vous plait inserer votre adresse mail associé à votre compte.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    //border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          "assets/HugeiconsAt.svg",
                          color: Colors.grey,
                          height: 25,
                          width: 25,
                          semanticsLabel: 'Dart Logo',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(""),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: userName,
                          showCursor: true,
                          //autofocus: true,
                          decoration: const InputDecoration(
                            //border: OutlineInputBorder(),
                            hintText: "Email ID  ",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(Get.size.width, 48),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    //Vendor
                    Get.to(Otp());
                  },
                  child: const Text(
                    "Soumettre",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
}
