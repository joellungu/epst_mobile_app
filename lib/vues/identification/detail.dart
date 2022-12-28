import 'package:accordion/accordion.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/identification/identification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatefulWidget {
  Map e;
  bool v;
  String role, province, district;
  Details(this.e, this.v, this.role, this.province, this.district);
  @override
  State<StatefulWidget> createState() {
    return _Details();
  }
}

class _Details extends State<Details> {
  Map e = {};
  @override
  void initState() {
    super.initState();
    //
    e = widget.e;
  }

  IdentificationController identificationController = Get.find();
  RxInt show = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "${Connexion.lien}${int.parse(widget.role) == 7 ? 'documentscolaire' : int.parse(widget.role) == 13 ? 'transfere' : 'identification'}/piecejointe/${widget.e['id']}")),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          int.parse(widget.role) != 13
              ? Column(
                  children: [
                    Text(
                      "${e['annee']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "réfèrence de la demande: ${e['id']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nom: ${e['nom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Postnom: ${e['postnom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prenom: ${e['prenom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "sexe: ${e['sexe']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lieuNaissance: ${e['lieuNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "dateNaissance: ${e['dateNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "telephone: ${e['telephone']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "nompere: ${e['nompere']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "adresse: ${e['adresse']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "provinceOrigine: ${e['provinceOrigine']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecole: ${e['ecole']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEcole: ${e['provinceEcole']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "provinceEducationnel: ${e['provinceEducationnel']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "option: ${e['option']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "annee: ${e['annee']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "documenrDemandecode: ${widget.v ? e['documenrDemandecode'] : e['typeIdentificationcode']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "documenrDemande: ${widget.v ? e['documenrDemande'] : e['typeIdentification']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "id: ${e['id']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nom: ${e['nom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Postnom: ${e['postnom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prenom: ${e['prenom']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "sexe: ${e['sexe']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lieuNaissance: ${e['lieuNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "dateNaissance: ${e['dateNaissance']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "telephone: ${e['telephone']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "nompere: ${e['nompere']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "nommere: ${e['nommere']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Téléphone: ${e['telephone']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "adresse: ${e['adresse']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "option avant: ${e['option_avant']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "option apres: ${e['option_apres']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "provinceOrigine: ${e['provinceOrigine']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecole provenance: ${e['ecoleProvenance']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecoleProvenanceProv: ${e['ecoleProvenanceProv']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecoleProvenanceDistric: ${e['ecoleProvenanceDistric']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecoleDestination: ${e['ecoleDestination']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecoleDestinationProv: ${e['ecoleDestinationProv']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ecoleDestinationDistric: ${e['ecoleDestinationDistric']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "datedemande: ${e['datedemande'] ?? ''}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: FutureBuilder(
          //     future: getStatus("${e['id']}"),
          //     builder: (context, t) {
          //       if (t.hasData) {
          //         int v = t.data as int;
          //         print("Valider ou: $v");
          //         show.value = v;
          //         //setState((){});
          //         return Container(
          //           height: 100,
          //           child: Column(
          //             children: [
          //               v == 1
          //                   ? Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text(
          //                         "Validation: Validé",
          //                         style: TextStyle(fontSize: 20),
          //                       ),
          //                     )
          //                   : v == 2
          //                       ? Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: Text(
          //                             "Validation: Refusé",
          //                             style: TextStyle(fontSize: 20),
          //                           ),
          //                         )
          //                       : v == 3
          //                           ? Align(
          //                               alignment: Alignment.centerLeft,
          //                               child: Text(
          //                                 "Validation MESP: Expiré",
          //                                 style: TextStyle(fontSize: 20),
          //                               ),
          //                             )
          //                           : Align(
          //                               alignment: Alignment.centerLeft,
          //                               child: Text(
          //                                 "Validation MESP: En attente",
          //                                 style: TextStyle(fontSize: 20),
          //                               ),
          //                             ),
          //               const SizedBox(
          //                 height: 20,
          //               ),
          //               Container(
          //                 height: 50,
          //                 child: v == 1
          //                     ? Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceAround,
          //                         children: [
          //                           // Expanded(
          //                           //   flex: 6,
          //                           //   child: TextField(
          //                           //     controller: cenome,
          //                           //     decoration: InputDecoration(
          //                           //       hintText:
          //                           //           "Cenome medecin",
          //                           //       border:
          //                           //           OutlineInputBorder(
          //                           //         borderRadius:
          //                           //             BorderRadius
          //                           //                 .circular(10),
          //                           //         borderSide:
          //                           //             const BorderSide(
          //                           //           color: Colors.black,
          //                           //         ),
          //                           //       ),
          //                           //     ),
          //                           //   ),
          //                           // ),
          //                           // const SizedBox(
          //                           //   width: 10,
          //                           // ),
          //                           // Expanded(
          //                           //   flex: 3,
          //                           //   child: ElevatedButton(
          //                           //     onPressed: () {
          //                           //       if (cenome
          //                           //           .text.isNotEmpty) {
          //                           //         mutuelleController
          //                           //             .setSaturer(
          //                           //                 this,
          //                           //                 l.value,
          //                           //                 index,
          //                           //                 "${e['id']}",
          //                           //                 cenome.text);
          //                           //       }
          //                           //     },
          //                           //     child:
          //                           //         const Text("Effectué"),
          //                           //   ),
          //                           // ),
          //                         ],
          //                       )
          //                     : Container(),
          //               ),
          //             ],
          //           ),
          //         );
          //         //return
          //       } else if (t.hasError) {
          //         return Text("...");
          //       }
          //       return Container(
          //         height: 50,
          //         width: 50,
          //         alignment: Alignment.center,
          //         child: CircularProgressIndicator(),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () async {
                  IdentificationController identificationController =
                      Get.find();
                  //
                  Get.dialog(
                    Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const CircularProgressIndicator(
                          strokeWidth: 7,
                        ),
                      ),
                    ),
                  );
                  //Get.back();
                  int v = await identificationController.setUpdate(
                      "${e['id']}", int.parse(widget.role), 1, "");
                  if (v == 1) {
                    //
                    Get.back();
                    //Get.back();

                    Get.snackbar("Effectué", "Demande expiré");
                    identificationController.getListe(int.parse(widget.role),
                        widget.province, widget.district);
                    //
                  } else {
                    Get.back();
                    Get.snackbar("Erreur",
                        "Un problème est survenu lors de la validation");

                    //getAllDemande(province, district);
                  }
                  //
                  identificationController.getListe(
                      int.parse(widget.role), widget.province, widget.district);
                },
                child: const Text("Valider"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  IdentificationController identificationController =
                      Get.find();
                  //

                  showDialog(
                      context: context,
                      builder: (c) {
                        TextEditingController raison = TextEditingController();
                        return Material(
                          color: Colors.transparent,
                          child: Center(
                            child: Container(
                              height: 300,
                              width: Get.size.width / 1.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 30,
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: raison,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        hintText: "Raison du refus",
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: const Text("Enregistrer"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    onPressed: () async {
                                      //
                                      Get.back();
                                      Get.dialog(
                                        Center(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 7,
                                            ),
                                          ),
                                        ),
                                      );
                                      int v = await identificationController
                                          .setUpdate(
                                        "${e['id']}",
                                        int.parse(widget.role),
                                        2,
                                        raison.text,
                                      );
                                      if (v == 1) {
                                        //
                                        Get.back();
                                        //Get.back();

                                        Get.snackbar("Effectué",
                                            "Information enregistré");
                                        identificationController.getListe(
                                            int.parse(widget.role),
                                            widget.province,
                                            widget.district);
                                        //
                                      } else {
                                        Get.back();
                                        Get.snackbar("Erreur",
                                            "Un problème est survenu lors de la validation");

                                        //getAllDemande(province, district);
                                      }
                                      //
                                      identificationController.getListe(
                                          int.parse(widget.role),
                                          widget.province,
                                          widget.district);
                                    },
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        );
                      });
                  //Get.back();
                },
                child: const Text("Réfuser"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  //
  Future<int> getStatus(String id) async {
    return identificationController.getStatus(id, widget.v);
  }
  //
}
