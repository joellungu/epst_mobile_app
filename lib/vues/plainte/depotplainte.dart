import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/reference.dart';
import 'package:epst_app/vues/plainte/transsfere.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'plainte_historique.dart';

class DepotPlainte extends StatefulWidget {
  String? titre;

  DepotPlainte({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DepotPlainte();
  }
}

class _DepotPlainte extends State<DepotPlainte> {
  bool exp = false;
  TextEditingController deC = TextEditingController();
  TextEditingController telephoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController aC = TextEditingController();
  TextEditingController messageC = TextEditingController();

  int a = 0;
  int p = 0;
  var Fichier = "";
  List listeProvince = [
    "Bas-Uele",
    "Equateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasaï",
    "Kasaï central",
    "Kasaï oriental",
    "Kinshasa",
    "Kongo-Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];
  //
  int ti = 0;
  //
  List listeFichierSave = [];
  //
  List listeTiquet = [
    "Gratuité de l'enseignement",
    "Violences basées sur le genre",
    "Diplôme d’Etat ",
    "ENAFEP",
    "TENASOSP",
    "Mesure diciplinaire",
    "Salaire ou prime",
    "Corruption",
    "Matricule",
    "Autres...",
  ];
  //
  DepotController depotController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.menu),
            onSelected: (e) {
              //
              if (e == 1) {
                Get.to(const PlainteHis());
              } else {
                Get.to(const References());
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Historique"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Reference"),
                ),
              ];
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: deC,
                decoration: InputDecoration(
                  //prefixIcon: Text("De:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("De:"),
                  //prefixText: "De: "
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: telephoneC,
                decoration: InputDecoration(
                    //prefixIcon: Text("Téléphone:"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    label: const Text("Téléphone:")
                    //prefixText: "De: "
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("Email:"),
                  //prefixText: "De: "
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //   controller: aC,
              //   decoration: InputDecoration(
              //     //prefixIcon: Text("Email:"),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide(
              //         color: Colors.blue,
              //       ),
              //     ),
              //     label: Text("À:"),
              //     //prefixText: "De: "
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("  Province:"),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: p,
                            onChanged: (value) {
                              value = p;
                            },
                            items: List.generate(
                              listeProvince.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeProvince[index]),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "  Thématique:",
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: a,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            isExpanded: true,
                            onChanged: (value) {
                              a = value as int;
                              print("le id: $a");
                            },
                            items: List.generate(
                              listeTiquet.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeTiquet[index]),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                //margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: messageC,
                          //maxLength: 10,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "  Message",
                            border: InputBorder.none,
                            //prefixText: "De: "
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          decoration: const BoxDecoration(
                            //color: Colors.yellow,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(Fichier),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool v1 = await Permission.storage.isGranted;
                                  bool v2 = await Permission
                                      .manageExternalStorage.isGranted;
                                  //
                                  Map<Permission, PermissionStatus> statuses =
                                      await [
                                    Permission.storage,
                                    Permission.manageExternalStorage,
                                  ].request();
                                  //
                                  var storage = statuses[Permission.storage];
                                  var manageExternalStorage = statuses[
                                      Permission.manageExternalStorage];
                                  if (storage!.isGranted ||
                                      manageExternalStorage!.isGranted) {
                                    // do something
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(allowMultiple: false);
                                    if (result != null) {
                                      List<File> files = result.paths
                                          .map((path) => File(path!))
                                          .toList();
                                      files.forEach((element) async {
                                        //
                                        List<String> extT =
                                            element.path.split(".");
                                        String ext = extT.last;
                                        String name = extT.first;
                                        Uint8List l =
                                            await element.readAsBytes();
                                        //
                                        listeFichierSave.add(element.path);
                                        //
                                        depotController.listeFichier.value.add(
                                          {
                                            "length": l.length,
                                            "data": l,
                                            "type": ext,
                                            "name": name,
                                          },
                                        );
                                      });
                                    }
                                    setState(() {});
                                  } else {
                                    Get.snackbar("Permission", "Oups !");
                                  }
                                  //

                                  //
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Joindre un document",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.attach_file,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      List.generate(depotController.listeFichier.length, (x) {
                    return ListTile(
                      leading: const Icon(Icons.file_present),
                      title: Text("Piece n° $x"),
                      trailing: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            listeFichierSave.removeAt(x);
                            depotController.listeFichier.removeAt(x);
                          });
                          //
                        },
                        icon: const Icon(Icons.close),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (deC.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ provenance");
                  } else if (telephoneC.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ téléphone");
                  } else if (emailC.text.isEmpty) {
                    messageErreur("Erreur", "Veuillez remplire le champ email");
                  } else if (messageC.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ message");
                  } else {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    //
                    if (connectivityResult
                            .contains(ConnectivityResult.mobile) ||
                        connectivityResult.contains(ConnectivityResult.wifi)) {
                      // I am connected to a mobile network. I am connected to a wifi network.
                      //
                      Map<String, dynamic> utilisateur = {
                        "envoyeur": deC.text,
                        "telephone": telephoneC.text,
                        "email": emailC.text,
                        "destinateur": aC.text,
                        "id_tiquet": a,
                        "message": messageC.text,
                        "id_statut": 0,
                        "piecejointe_id": "",
                        "reference": getReference(),
                        "date": "${DateTime.now()}",
                        "province": "${listeProvince[p]}",
                        "envoyer": "oui"
                      };

                      deC.clear();
                      telephoneC.clear();
                      emailC.clear();
                      aC.clear();
                      messageC.clear();
                      a = 0;
                      p = 0;
                      print("_____________________: $utilisateur");
                      List<Map<String, dynamic>> l = [];
                      //____________________________________________________________
                      for (var element in depotController.listeFichier) {
                        Map<String, dynamic> e = element;
                        l.add(e);
                      }
                      //____________________________________________________________
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Transfere1(utilisateur, l);
                          },
                        ),
                      );
                      depotController.listeFichier.clear();
                    } else {
                      //
                      var box = GetStorage();
                      //
                      List<Map<String, dynamic>> l = [];
                      //____________________________________________________________
                      for (var element in depotController.listeFichier) {
                        Map<String, dynamic> e = element;
                        l.add(e);
                      }

                      var ref = getReference();
                      Map<String, dynamic> utilisateur = {
                        "envoyeur": deC.text,
                        "telephone": telephoneC.text,
                        "email": emailC.text,
                        "destinateur": aC.text,
                        "id_tiquet": a,
                        "message": messageC.text,
                        "id_statut": 0,
                        "piecejointe_id": "",
                        "reference": ref,
                        "date": "${DateTime.now()}",
                        "province": "${listeProvince[p]}",
                        "envoyer": "non"
                      };

                      deC.clear();
                      telephoneC.clear();
                      emailC.clear();
                      aC.clear();
                      messageC.clear();
                      a = 0;
                      p = 0;
                      print("_____________________: $utilisateur");
                      //____________________________________________________________
                      //____________________________________________________________
                      //
                      Historique historique = Historique();
                      //
                      Database db = await historique.openDB();
                      db.insert("historique", utilisateur);
                      //[utilisateur]
                      //Très important pour envoyer les fichiers plus tard je n'enregistre que les paths de ces fichiers !
                      box.write(ref, listeFichierSave);
                      //
                      //listeFichierSave.addAll(l);
                      depotController.listeFichier.clear();
                      l.clear();
                      //
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Plainte enregitré"),
                            content: const Text(
                                "Cliquez dans historique en haut à droit pour l'envoyer."),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.check),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: const Text("Envoyer"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  messageErreur(String titre, String message) {
    //GetSnackBar(title: titre, message: message);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titre),
          content: Text(message),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        );
      },
    );
  }

  String getReference() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<void> _createFolderAndSave(
      String folderName, List<Map<String, dynamic>> liste) async {
    try {
      //
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      //final folderName = "some_name";
      final path = Directory("$appDocPath/$folderName");
      if ((await path.exists())) {
        // TODO:
        print("exist");
      } else {
        path.create();
        for (int t = 0; t < liste.length; t++) {
          //
          File("${path.create()}/t.${liste[t]['type']}")
              .create(recursive: true)
              .then((File file) {
            //
            file.writeAsBytes(liste[t]["data"]); //
          });
        }
        //print("not exist");
      }
    } catch (e) {
      print("_______________: $e");
    }
  }

  /*
  getFile2(bool v) async {
    final ImagePicker _picker = ImagePicker();
    if (v) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    } else {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    }
    // Pick an image
    //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo

    // Pick a video
    //final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    // Capture a video

    // Pick multiple images
    //final List<XFile>? images = await _picker.pickMultiImage();
  }
  */
}

/*
SizedBox(height: 20,),
              Container(height: 50,
              child: Flexible(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 25.0,
                    maxHeight: 135.0,
                  ),
                  child: new Scrollbar(
                    child: new TextField(
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //controller: tc,
                      //_handleSubmitted : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 2.0,
                            left: 13.0,
                            right: 13.0,
                            bottom: 2.0),
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                          color:Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ),
 */


