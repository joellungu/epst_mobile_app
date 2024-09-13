import 'package:epst_app/vues/formation/cursus/login/login_enseignant/login_controller.dart';
import 'package:epst_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InfosPersonnel extends StatelessWidget {
  //
  Map infos;
  //
  LoginEnseignantController loginEnseignantController = Get.find();
  //
  TextEditingController otp = TextEditingController();
  //
  var box = GetStorage();
  //
  final formKey = GlobalKey<FormState>();
  final telephone = TextEditingController();
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  final dateNaissance = TextEditingController();
  final genre = TextEditingController();
  final type = TextEditingController();
  final lieuExcercice = TextEditingController();
  final province = TextEditingController();
  final email = TextEditingController();
  //
  String codePays = "+243";
  //
  RxBool vue = true.obs;

  //LoginController loginController = Get.find();
  //
  RxBool masquer = true.obs;

  //
  InfosPersonnel(this.infos, {Key? key}) : super(key: key) {
    telephone.text = infos['telephone'] ?? "";
    nom.text = infos['nom'] ?? "";
    postnom.text = infos['postnom'] ?? "";
    prenom.text = infos['prenom'] ?? "";
    adresse.text = infos['adresse'] ?? "";
    //dateNaissance.text = infos['dateNaissance'];
    genre.text = infos['genre'] ?? "";
    type.text = infos['type'] ?? "";
    lieuExcercice.text = infos['lieuExcercie'] ?? "";
    province.text = infos['province'] ?? "";
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infos personnel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nom",
                      style: textStyle,
                    ),
                  ),
                  //
                  TextFormField(
                    controller: nom,
                    textCapitalization: TextCapitalization.words,
                    //textAlign: TextAlign.center,
                    //keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //autofocus: true,
                    //focusNode: FocusNode(skipTraversal: true),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Veuilliez inserer votre nom";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Postnom",
                      style: textStyle,
                    ),
                  ),
                  //
                  TextFormField(
                    controller: postnom,
                    textCapitalization: TextCapitalization.words,
                    //textAlign: TextAlign.center,
                    //keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //autofocus: true,
                    //focusNode: FocusNode(skipTraversal: true),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Veuilliez inserer votre postnom";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Prenom",
                      style: textStyle,
                    ),
                  ),
                  //
                  TextFormField(
                    controller: prenom,
                    textCapitalization: TextCapitalization.words,
                    //textAlign: TextAlign.center,
                    //keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //autofocus: true,
                    //focusNode: FocusNode(skipTraversal: true),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Veuilliez inserer votre prenom";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Genre",
                      style: textStyle,
                    ),
                  ),
                  //
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: genre,
                          enabled: false,
                          //textAlign: TextAlign.center,
                          //keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          //autofocus: true,
                          //focusNode: FocusNode(skipTraversal: true),
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Veuilliez inserer votre numéro de téléphone";
                            } else if (e.length >= 10) {
                              return "Le numéro n'est pas correct !";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (t) {
                          //
                          print("T:$t");
                          genre.text = ["Femme", "Homme"][t as int];
                        },
                        itemBuilder: (c) {
                          return const [
                            PopupMenuItem(
                              value: 0,
                              child: Text("Femme"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Homme"),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     //
                      //   },
                      //   icon: const Icon(Icons.edit),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Type de profile",
                      style: textStyle,
                    ),
                  ),
                  //
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: genre,
                          enabled: false,
                          //textAlign: TextAlign.center,
                          //keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          //autofocus: true,
                          //focusNode: FocusNode(skipTraversal: true),
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Veuilliez indiquer le type";
                            } else if (e.length >= 10) {
                              return "Le numéro n'est pas correct !";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (t) {
                          //
                          print("T:$t");
                          type.text = ["Elève", "Enseignant"][t as int];
                        },
                        itemBuilder: (c) {
                          return const [
                            PopupMenuItem(
                              value: 0,
                              child: Text("Elève"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Enseignant"),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     //
                      //   },
                      //   icon: const Icon(Icons.edit),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Téléphone",
                      style: textStyle,
                    ),
                  ),
                  //
                  TextFormField(
                    controller: telephone,
                    enabled: false,
                    textCapitalization: TextCapitalization.words,
                    //textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //autofocus: true,
                    //focusNode: FocusNode(skipTraversal: true),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Veuilliez inserer votre numéro de téléphone";
                      } else if (e.length >= 10) {
                        return "Le numéro n'est pas correct !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefix: const Text(
                        "+ ",
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Adresse",
                      style: textStyle,
                    ),
                  ),
                  //
                  TextFormField(
                    controller: adresse,
                    //textAlign: TextAlign.center,
                    //keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //autofocus: true,
                    //focusNode: FocusNode(skipTraversal: true),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Veuilliez inserer votre adresse de residnace";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Province",
                      style: textStyle,
                    ),
                  ),
                  //
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: province,
                          enabled: false,
                          //textAlign: TextAlign.center,
                          //keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          //autofocus: true,
                          //focusNode: FocusNode(skipTraversal: true),
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Veuilliez inserer votre numéro de téléphone";
                            } else if (e.length >= 10) {
                              return "Le numéro n'est pas correct !";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (t) {
                          //
                          print("T:$t");
                          province.text = ["Kinshasa"][t as int];
                        },
                        itemBuilder: (c) {
                          return const [
                            PopupMenuItem(
                              value: 0,
                              child: Text("Kinshasa"),
                            ),
                            // PopupMenuItem(
                            //   value: 1,
                            //   child: Text("Homme"),
                            // ),
                          ];
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     //
                      //   },
                      //   icon: const Icon(Icons.edit),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     "Votre lieux d'exercice",
                  //     style: textStyle,
                  //   ),
                  // ),
                  // //
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: TextFormField(
                  //         controller: lieuExcercice,
                  //         enabled: false,
                  //         //textAlign: TextAlign.center,
                  //         //keyboardType: TextInputType.number,
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //         ),
                  //         //autofocus: true,
                  //         //focusNode: FocusNode(skipTraversal: true),
                  //         validator: (e) {
                  //           if (e!.isEmpty) {
                  //             return "Veuilliez inserer votre numéro de téléphone";
                  //           } else if (e!.length >= 10) {
                  //             return "Le numéro n'est pas correct !";
                  //           }
                  //           return null;
                  //         },
                  //         decoration: InputDecoration(
                  //           contentPadding:
                  //               const EdgeInsets.symmetric(vertical: 5),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.black, width: 2),
                  //           ),
                  //           prefixIcon: const Icon(
                  //             Icons.location_on,
                  //             color: Colors.blue,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         List le = [
                  //           "Bandal Tshibangu",
                  //           "Bandal Moalar",
                  //           "Bandal Kimbondo",
                  //           "Quartier GB (Diplomate)",
                  //           "Lemba Salongo",
                  //           "Lemba Super",
                  //           "Lemba Terminus",
                  //           "Matete",
                  //         ];
                  //         showModalBottomSheet(
                  //           isScrollControlled: true,
                  //           context: context,
                  //           builder: (c) {
                  //             return Container(
                  //               padding: EdgeInsets.all(10),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 children: [
                  //                   Container(
                  //                     height: 45,
                  //                   ),
                  //                   Expanded(
                  //                     flex: 1,
                  //                     child: ListView(
                  //                       children:
                  //                           List.generate(le.length, (index) {
                  //                         return ListTile(
                  //                           onTap: () {
                  //                             //
                  //                             lieuExcercice.text = le[index];
                  //                             Get.back();
                  //                           },
                  //                           leading:
                  //                               const Icon(Icons.location_on),
                  //                           title: Text(le[index]),
                  //                           subtitle: Text(
                  //                             le[index],
                  //                             style: const TextStyle(
                  //                               color: Colors.blue,
                  //                             ),
                  //                           ),
                  //                         );
                  //                       }),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       },
                  //       icon: const Icon(Icons.edit),
                  //     ),
                  //   ],
                  // ),

                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //
                      Loader.loading();
                      String token = box.read("token") ?? "";
                      /**
                           * agent1.nom = agent.nom;
                            agent1.postnom = agent.nom;
                            agent1.prenom = agent.nom;
                            agent1.telephone = agent.nom;
                            agent1.email = agent.nom;
                            agent1.adresse = agent.nom;
                            agent1.actif = agent.actif;
                            agent1.province = agent.nom;
                            agent1.commune = agent.nom;
                            agent1.lieuExcercie = agent.nom;
                            agent1.password = agent.password;
                           */
                      //
                      Map u = {
                        //"id": e['id'],
                        "nom": nom.text,
                        "postnom": postnom.text,
                        "prenom": prenom.text,
                        "genre": genre.text,
                        //"dateNaissance": dateNaissance.text,
                        "telephone": telephone.text,
                        "adresse": adresse.text,
                        "actif": true,
                        "province": province.text,
                        "lieuExcercie": lieuExcercice.text,
                        "password": "1234567",
                        "fbToken": token,
                        "latitude": 0.0,
                        "longitude": 0.0,
                        "competences": [],
                        "photos": [],
                      };
                      //
                      //loginEnseignantController.enregitrementFinal(u);
                      //loginController.enregitrementFinal(u);
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(
                        const Size(
                          double.maxFinite,
                          45,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: const Text(
                        "Enregistrer",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          //
                        },
                        child: const Text(
                          "Condition d'utilisation",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              //)
            ),
          ),
        ),
      ),
    );
  }
  //

  TextStyle textStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
