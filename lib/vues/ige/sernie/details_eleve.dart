import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailEleve extends StatefulWidget {
  //
  Map e;
  //
  int index;
  //
  DetailEleve(this.e, this.index, {Key? key}) : super(key: key);
  //

  @override
  State<StatefulWidget> createState() {
    return _DetailEleve();
  }
}

class _DetailEleve extends State<DetailEleve> {
  //
  Map e = {};
  //
  int index = 0;
  //
  var box = GetStorage();
  RxList l = RxList();
  //
  RxString text = "".obs;
  //
  @override
  void initState() {
    //
    e = widget.e;
    index = widget.index;
    //
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details élève"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            // child: Text(
            //   "code: ${e['id']}",
            //   textAlign: TextAlign.left,
            //   style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 17,
            //       fontWeight: FontWeight.normal),
            // ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Nom",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${e['nom']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "nom", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Postnom",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['postnom']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "postnom", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Prenom",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['prenom']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "prenom", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "sexe",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['sexe']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Lieu Naissance",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['lieuNaissance']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "lieuNaissance", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Date Naissance",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['dateNaissance']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "dateNaissance", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "telephone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['telephone']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "telephone", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Nom pere",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['nompere']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //

                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "nompere", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Nom mere",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['nommere']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "nommere", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "adresse",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${e['adresse']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "adresse", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "provinceOrigine",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['provinceOrigine']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "provinceOrigine", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "ecole",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['ecole']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "ecole", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "province Ecole",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['provinceEcole']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "provinceEcole", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "provinceEducationnel",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['provinceEducationnel']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "provinceEducationnel", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "option",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['option']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "option", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "classe",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['option']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "option", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "annee",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['annee']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "annee", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          /*
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Identification: ${e['typeIdentification']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    */
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Territoire",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['territoire']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "territoire", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Secteur",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['secteur']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "secteur", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Groupement",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['groupement']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "groupement", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Village",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['village']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "village", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Nationalite",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['nationalite']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "nationalite", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            //alignment: Alignment.centerLeft,
            title: const Text(
              "Antenne",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(
              "${e['antenne']}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            trailing: IconButton(
              onPressed: () {
                //
                //
                TextEditingController text = TextEditingController();
                //
                modifierInfo(e, context, text, "antenne", index);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  modifierInfo(
    Map e,
    BuildContext context,
    TextEditingController text,
    String nom,
    int index,
  ) async {
    text.text = e[nom];
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("${nom.capitalize}"),
            contentPadding: const EdgeInsets.all(5),
            content: SizedBox(
              height: 200,
              width: 250,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //prefixIcon: const Icon(Icons.person),
                          hintText: 'nom'.tr,
                          labelText: 'nom'.tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'nom_message'.tr;
                          }

                          return null;
                        },
                        onChanged: (value) {
                          //print("Password value $value");
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          e[nom] = text.text;
                          // Get.dialog(
                          //   const Center(
                          //     child: SizedBox(
                          //       height: 40,
                          //       width: 40,
                          //       child: CircularProgressIndicator(),
                          //     ),
                          //   ),
                          // );
                          l.value = box.read("historique_sernie") ?? [];
                          l.value = l.value.reversed.toList();
                          //
                          l.value[index] = e;
                          Get.back();
                          Get.snackbar("Modification",
                              "La modification éffectué avec succès");
                          //
                          box.write("historique_sernie", l);
                          //
                          setState(() {});
                          //agentController.putDataAgent(e);
                          //Mise ) jour ici...
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 2,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade900,
                              borderRadius: BorderRadius.circular(10),
                              // gradient: LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   colors: <Color>[Colors.yellow.shade700, Colors.black],
                              // ),
                            ),
                            child: Text(
                              "Modifier".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
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
        });
  }
}
