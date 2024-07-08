import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/identification/identification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailSernie extends StatefulWidget {
  Map e;
  int index;
  Map inspecteur;

  DetailSernie(this.e, this.index, this.inspecteur, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Details();
  }
}

class _Details extends State<DetailSernie> {
  Map e = {};
  int index = 0;
  //
  IdentificationController identificationController = Get.find();
  //
  var box = GetStorage();
  //
  @override
  void initState() {
    super.initState();
    //
    e = widget.e;
    index = widget.index;
    print('validé: ${e['valider']}');
    //
  }

  RxInt show = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.size.height / 2.5,
                  width: Get.size.width / 1.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${Connexion.lien}sernie/piecejointe/${e['id']}")),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ],
            ),
          ),
          Column(
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
                    modifierInfo(
                        e, context, text, "provinceEducationnel", index);
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
              //
              const SizedBox(
                height: 10,
              ),
              //
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Validation",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                          //////////////////////////////////////////////////////////////////
                          List ld = box.read("historique_demande_sernie") ?? [];
                          //l.value = l.value.reversed.toList();
                          //
                          e['valider'] = 1;
                          //
                          ld[index] = e;
                          Get.back();

                          //
                          box.write("historique_demande_sernie", ld);
                          Get.snackbar("Modification",
                              "La modification éffectué avec succès");

                          setState(() {});
                          //

                          identificationController.getListeSernie(
                              e['provinceEcole'],
                              e['provinceEducationnel'],
                              e['antenne']);
                        },
                        style: ButtonStyle(
                            // backgroundColor:
                            //     WidgetStateProperty.all(Colors.green),
                            ),
                        child: const Text("Valider"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                          TextEditingController text = TextEditingController();
                          //
                          Get.dialog(Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(30),
                                padding: const EdgeInsets.all(10),
                                height: 250,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: text,
                                        maxLines: 7,
                                        decoration: InputDecoration(
                                          label: const Text(
                                              "Commentaire de réfus"),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            //
                                            if (text.text.isNotEmpty) {
                                              //////////////////////////////////////////////////////////////////
                                              List ld = box.read(
                                                      "historique_demande_sernie") ??
                                                  [];
                                              //l.value = l.value.reversed.toList();
                                              //
                                              e['valider'] = 2;
                                              e['raison'] = text.text;
                                              //
                                              ld[index] = e;
                                              Get.back();

                                              //
                                              box.write(
                                                  "historique_demande_sernie",
                                                  ld);
                                              Get.snackbar("Modification",
                                                  "La modification éffectué avec succès");

                                              setState(() {});
                                              //

                                              identificationController
                                                  .getListeSernie(
                                                      e['provinceEcole'],
                                                      e['provinceEducationnel'],
                                                      e['antenne']);
                                            } else {
                                              Get.defaultDialog(
                                                title: "Raison",
                                                content: const Text(
                                                    "Veuillez saisir une raison de l'invalidation."),
                                              );
                                            }
                                          },
                                          style: ButtonStyle(
                                              //backgroundColor:
                                              // WidgetStateProperty.all(
                                              //     Colors.green),
                                              ),
                                          child: const Text("Confirmer"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ButtonStyle(
                                              //backgroundColor:
                                              // WidgetStateProperty.all(
                                              //     Colors.red),
                                              ),
                                          child: const Text("Annuler"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                        style: ButtonStyle(
                            //backgroundColor:
                            //  WidgetStateProperty.all(Colors.red),
                            ),
                        child: const Text("Invalider"),
                      ),
                    ),
                  ],
                ),
              ),
              //
              const SizedBox(
                height: 15,
              ),
              //
              // ListTile(
              //   //alignment: Alignment.centerLeft,
              //   title: const Text(
              //     "Valider",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 17,
              //         fontWeight: FontWeight.normal),
              //   ),
              //   subtitle: Text(
              //     "${e['valider']}",
              //     style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 17,
              //         fontWeight: FontWeight.normal),
              //   ),
              //   trailing: IconButton(
              //     onPressed: () {
              //       //
              //       //
              //       TextEditingController text = TextEditingController();
              //       //
              //       modifierInfo(e, context, text, "valider", index);
              //     },
              //     icon: const Icon(Icons.edit),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   height: 50,
      //   child: Row(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: ElevatedButton(
      //           onPressed: () async {
      //             IdentificationController identificationController =
      //                 Get.find();
      //             //
      //             Get.dialog(
      //               Center(
      //                 child: Container(
      //                   height: 40,
      //                   width: 40,
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(20),
      //                   ),
      //                   child: const CircularProgressIndicator(
      //                     strokeWidth: 7,
      //                   ),
      //                 ),
      //               ),
      //             );
      //             //Get.back();
      //             int v = await identificationController.setUpdate(
      //                 "${e['id']}", int.parse(widget.role), 1, "");
      //             if (v == 1) {
      //               //
      //               Get.back();
      //               //Get.back();

      //               Get.snackbar("Effectué", "Demande expiré");
      //               identificationController.getListe(int.parse(widget.role),
      //                   widget.province, widget.district);
      //               //
      //             } else {
      //               Get.back();
      //               Get.snackbar("Erreur",
      //                   "Un problème est survenu lors de la validation");

      //               //getAllDemande(province, district);
      //             }
      //             //
      //             identificationController.getListe(
      //                 int.parse(widget.role), widget.province, widget.district);
      //           },
      //           child: const Text("Valider"),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Expanded(
      //         flex: 4,
      //         child: ElevatedButton(
      //           style: ButtonStyle(
      //             backgroundColor: MaterialStateProperty.all(Colors.red),
      //           ),
      //           onPressed: () async {
      //             IdentificationController identificationController =
      //                 Get.find();
      //             //

      //             showDialog(
      //                 context: context,
      //                 builder: (c) {
      //                   TextEditingController raison = TextEditingController();
      //                   return Material(
      //                     color: Colors.transparent,
      //                     child: Center(
      //                       child: Container(
      //                         padding: const EdgeInsets.all(20),
      //                         height: 300,
      //                         width: Get.size.width / 1.2,
      //                         child: Column(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceAround,
      //                           children: [
      //                             Container(
      //                               height: 30,
      //                               alignment: Alignment.centerRight,
      //                               child: IconButton(
      //                                 onPressed: () {
      //                                   Get.back();
      //                                 },
      //                                 icon: const Icon(
      //                                   Icons.close,
      //                                   color: Colors.black,
      //                                 ),
      //                               ),
      //                             ),
      //                             Expanded(
      //                               flex: 1,
      //                               child: TextField(
      //                                 controller: raison,
      //                                 maxLines: 10,
      //                                 decoration: InputDecoration(
      //                                   hintText: "Raison du refus",
      //                                   border: OutlineInputBorder(
      //                                     borderRadius:
      //                                         BorderRadius.circular(20),
      //                                     borderSide: const BorderSide(
      //                                       color: Colors.black,
      //                                       width: 1,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             ElevatedButton(
      //                               child: const Text("Enregistrer"),
      //                               style: ButtonStyle(
      //                                 backgroundColor:
      //                                     MaterialStateProperty.all(Colors.red),
      //                               ),
      //                               onPressed: () async {
      //                                 //
      //                                 Get.back();
      //                                 Get.dialog(
      //                                   Center(
      //                                     child: Container(
      //                                       height: 40,
      //                                       width: 40,
      //                                       decoration: BoxDecoration(
      //                                         color: Colors.white,
      //                                         borderRadius:
      //                                             BorderRadius.circular(20),
      //                                       ),
      //                                       child:
      //                                           const CircularProgressIndicator(
      //                                         strokeWidth: 7,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 );
      //                                 int v = await identificationController
      //                                     .setUpdate(
      //                                   "${e['id']}",
      //                                   int.parse(widget.role),
      //                                   2,
      //                                   raison.text,
      //                                 );
      //                                 if (v == 1) {
      //                                   //
      //                                   Get.back();
      //                                   //Get.back();

      //                                   Get.snackbar("Effectué",
      //                                       "Information enregistré");
      //                                   identificationController.getListe(
      //                                       int.parse(widget.role),
      //                                       widget.province,
      //                                       widget.district);
      //                                   //
      //                                 } else {
      //                                   Get.back();
      //                                   Get.snackbar("Erreur",
      //                                       "Un problème est survenu lors de la validation");

      //                                   //getAllDemande(province, district);
      //                                 }
      //                                 //
      //                                 identificationController.getListe(
      //                                     int.parse(widget.role),
      //                                     widget.province,
      //                                     widget.district);
      //                               },
      //                             )
      //                           ],
      //                         ),
      //                         decoration: BoxDecoration(
      //                             color: Colors.white,
      //                             borderRadius: BorderRadius.circular(10)),
      //                       ),
      //                     ),
      //                   );
      //                 });
      //             //Get.back();
      //           },
      //           child: const Text("Réfuser"),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

//
  modifierInfo(
    Map e,
    BuildContext context,
    TextEditingController text,
    String nom,
    int index,
  ) async {
    text.text = "${e[nom]}";
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
                        //////////////////////////////////////////////////////////////////
                        List ld = box.read("historique_demande_sernie") ?? [];
                        //l.value = l.value.reversed.toList();
                        //
                        ld[index] = e;
                        Get.back();

                        //
                        box.write("historique_demande_sernie", ld);
                        Get.snackbar("Modification",
                            "La modification éffectué avec succès");

                        setState(() {});
                        //

                        identificationController.getListeSernie(
                            e['provinceEcole'],
                            e['provinceEducationnel'],
                            e['antenne']);
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
      },
    );
  }
}
