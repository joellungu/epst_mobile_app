import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailEleve extends StatefulWidget {
  //
  Map e;
  //
  int index;
  //
  DetailEleve(this.e, this.index);
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
          Align(
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
            title: Text(
              "Postnom",
              style: const TextStyle(
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
            title: Text(
              "Prenom",
              style: const TextStyle(
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
            title: Text(
              "sexe",
              style: const TextStyle(
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
            title: Text(
              "Lieu Naissance",
              style: const TextStyle(
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
            title: Text(
              "telephone",
              style: const TextStyle(
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
            title: Text(
              "Nom pere",
              style: const TextStyle(
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
            title: Text(
              "Nom mere",
              style: const TextStyle(
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
            title: Text(
              "adresse",
              style: const TextStyle(
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
            title: Text(
              "provinceOrigine",
              style: const TextStyle(
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
            title: Text(
              "ecole",
              style: const TextStyle(
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
            title: Text(
              "province Ecole",
              style: const TextStyle(
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
            title: Text(
              "provinceEducationnel",
              style: const TextStyle(
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
            title: Text(
              "option",
              style: const TextStyle(
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
            title: Text(
              "classe",
              style: const TextStyle(
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
            title: Text(
              "annee",
              style: const TextStyle(
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
            title: Text(
              "Territoire",
              style: const TextStyle(
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
            title: Text(
              "Secteur",
              style: const TextStyle(
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
            title: Text(
              "Groupement",
              style: const TextStyle(
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
            title: Text(
              "Village",
              style: const TextStyle(
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
            title: Text(
              "Nationalite",
              style: const TextStyle(
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
            title: Text(
              "Antenne",
              style: const TextStyle(
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
            content: Container(
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
                            child: Text(
                              "Modifier".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
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
