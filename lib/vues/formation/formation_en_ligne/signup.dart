import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'otp.dart';

class Signup extends StatelessWidget {
  //
  TextEditingController userName = TextEditingController();
  //
  TextEditingController password = TextEditingController();
  //
  RxString showPassword = "HugeiconsView".obs;
  //
  RxString niveau = "Primaire".obs;
  //
  RxInt classe = 1.obs;
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
                  height: 220,
                  width: 220,
                  //child: SvgPicture.asset("assets/SolarUserRoundedLinear.svg"),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage("assets/LOGO-MINEPST-BON.png")),
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Creation de compte",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
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
                          "assets/HugeiconsUser.svg",
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
                            hintText: "Nom d'utilisateur",
                          ),
                        ),
                      )
                    ],
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
                        //alignment: Alignment.center,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          "assets/HugeiconsCall.svg",
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
                          showCursor: true,
                          //autofocus: true,
                          keyboardType: TextInputType.phone,
                          controller: password,
                          obscureText: showPassword.value == "HugeiconsView",
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                            hintText: 'Téléphone',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ///////////////////////////////////////////////////
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Niveau",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                        //alignment: Alignment.center,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          "assets/HugeiconsLocationUser01.svg",
                          color: Colors.grey,
                          height: 25,
                          width: 25,
                          semanticsLabel: 'Dart Logo',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton<String>(
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Primaire"),
                                  value: "Primaire",
                                ),
                                DropdownMenuItem(
                                  child: Text("Sécondaire"),
                                  value: "Sécondaire",
                                ),
                              ],
                              isExpanded: true,
                              value: niveau.value,
                              onChanged: (c) {
                                //
                                niveau.value = c!;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Classe",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                        //alignment: Alignment.center,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          "assets/HugeiconsBookshelf03.svg",
                          color: Colors.grey,
                          height: 25,
                          width: 25,
                          semanticsLabel: 'Dart Logo',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton<int>(
                              items: List.generate(8, (e) {
                                return DropdownMenuItem(
                                  value: e + 1,
                                  child: Text("${e + 1}e"),
                                );
                              }),
                              isExpanded: true,
                              value: classe.value,
                              onChanged: (c) {
                                //
                                classe.value = c!;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                RichText(
                  text: const TextSpan(
                      text: "En creant un compte vous acceptez nos ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            child: Text(
                              "Termes et conditions ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(text: " et notre "),
                        WidgetSpan(
                          child: InkWell(
                            child: Text(
                              "Politique de confidentialité",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 25,
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
                    Get.dialog(
                      Center(
                        child: Card(
                          child: Container(
                            height: 170,
                            width: 200,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.check,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Vous allez recevoir vos identidiants par SMS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    //Get.to(Otp());
                  },
                  child: const Text(
                    "Connexion",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        //fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          //fontSize: 10,
                        ),
                      ),
                    ),
                  ],
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
