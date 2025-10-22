import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'classes.dart';
import 'forgot.dart';
import 'signup.dart';

class LoginFL extends StatelessWidget {
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 200,
                //child: SvgPicture.asset("assets/SolarUserRoundedLinear.svg"),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: ExactAssetImage("assets/logo_min_edu_nc.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.transparent,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Connexion",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
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
                height: 5,
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
                        "assets/HugeiconsCircleLock02.svg",
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
                      child: Obx(
                        () => TextField(
                          showCursor: true,
                          //autofocus: true,
                          controller: password,
                          obscureText: showPassword.value == "HugeiconsView",
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                            hintText: 'Mot de passe',
                            suffixIcon: InkWell(
                              onTap: () {
                                //
                                print('truc');
                                showPassword.value == "HugeiconsViewOff"
                                    ? showPassword.value = "HugeiconsView"
                                    : showPassword.value = "HugeiconsViewOff";
                              },
                              child: Obx(
                                () => Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(),
                                  child: SvgPicture.asset(
                                    "assets/${showPassword.value}.svg",
                                    color: Colors.grey,
                                    height: 30,
                                    width: 30,
                                    semanticsLabel: 'Dart Logo',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(Forgot());
                    },
                    child: Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  //Vendor
                  //Get.offAll(Verificationotp());
                  //Get.offAll(Vendor());
                  if (userName.text.isEmpty || password.text.isEmpty) {
                    //
                    Get.to(Classes());
                    Get.snackbar("Oups", "Veuillez saisir tout les champs.");
                  } else {
                    //
                    // Loader.load();
                    // //
                    // Map user = {
                    //   "username": userName.text,
                    //   "password": password.text,
                    // };
                    // //

                    // //String username, String password
                    // loginController.getLogin(user);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Text("  "),
                  Expanded(
                    flex: 4,
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Pas de compte ?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      //fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(Signup());
                    },
                    child: Text(
                      "Créer un compte",
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
    );
  }
  //
}
