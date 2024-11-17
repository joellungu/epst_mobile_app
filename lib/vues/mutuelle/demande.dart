import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/plainte/transsfere.dart';
//import 'package:epst_app/vues/transsfere.dart';
import 'package:image_picker/image_picker.dart';
import 'mutuelle_controller.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Demande extends StatefulWidget {
  String? titre;

  Demande({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Demande();
  }
}

class _Demande extends State<Demande> {
  bool exp = false;
  TextEditingController nom = TextEditingController();
  TextEditingController postnom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController matricule = TextEditingController();
  TextEditingController notes = TextEditingController();
  //
  int a = 0;
  int s = 0;
  int b = 0;
  int p = 0;
  int d = 0;
  //
  var Fichier = "";
  List listeProvince = [
    "Bas-Uele",
    "Equateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasai",
    "Kasai central",
    "Kasai oriental",
    "Kinshasa",
    "Kongo Central",
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
  List<Map<String, dynamic>> listeDistrict2 = [
    {"p": "BAS-UELE", "d": "BAS-UELE"},
    {"p": "EQUATEUR", "d": "EQUATEUR 1"},
    {"p": "EQUATEUR", "d": "EQUATEUR 2"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 1"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 2"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 1"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 2"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 1"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 2"},
    {"p": "ITURI", "d": "ITURI 1"},
    {"p": "ITURI", "d": "ITURI 2"},
    {"p": "ITURI", "d": "ITURI 3"},
    {"p": "KASAI", "d": "KASAI 1"},
    {"p": "KASAI", "d": "KASAI 2"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 1"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 2"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 1"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 2"},
    {"p": "KINSHASA", "d": "KINSHASA-FUNA"},
    {"p": "KINSHASA", "d": "KINSHASA-LUKUNGA"},
    {"p": "KINSHASA", "d": "KINSHASA-MONT AMBA"},
    {"p": "KINSHASA", "d": "KINSHASA-PLATEAU"},
    {"p": "KINSHASA", "d": "KINSHASA-TSHANGU"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 1"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 2"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 3"},
    {"p": "KWANGO", "d": "KWANGO 1"},
    {"p": "KWANGO", "d": "KWANGO 2"},
    {"p": "KWILU", "d": "KWILU 1"},
    {"p": "KWILU", "d": "KWILU 2"},
    {"p": "KWILU", "d": "KWILU 3"},
    {"p": "LOMAMI", "d": "LOMAMI"},
    {"p": "LOMAMI", "d": "LOMAMI 2"},
    {"p": "LUALABA", "d": "LUALABA 1"},
    {"p": "LUALABA", "d": "LUALABA 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 1"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 3"},
    {"p": "MANIEMA", "d": "MANIEMA 1"},
    {"p": "MANIEMA", "d": "MANIEMA 2"},
    {"p": "MONGALA", "d": "MONGALA 1"},
    {"p": "MONGALA", "d": "MONGALA 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 1"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 3"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 1"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 2"},
    {"p": "SANKURU", "d": "SANKURU 1"},
    {"p": "SANKURU", "d": "SANKURU 2"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 2"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 1"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 3"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 1"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 2"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 1"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 2"},
    {"p": "TSHOPO", "d": "TSHOPO 1"},
    {"p": "TSHOPO", "d": "TSHOPO 2"},
    {"p": "TSHUAPA", "d": "TSHUAPA 1"},
    {"p": "TSHUAPA", "d": "TSHUAPA 2"}
  ];
  //
  List<String> listeDistrict = [];

  List<String> listeServices = [
    "Demande consulation",
    "Demande transfère",
    "Demande médicaments",
  ];
  //
  List<String> listeBeneficiaire = [
    "Moi-meme",
    "Epouse",
    "Enfant 1",
    "Enfant 2",
  ];
  //
  List<String> listeDiraction = [
    "Cabinet SG",
    "Cabinet IGE",
    "DGC",
    "DOI",
    "DANTIC",
    "DIPROMAD",
    "DIGE",
    "DRH",
    "MESP",
    "SERNAFOR maternel",
    "SERNAFOR primaire",
    "SERNAFOR secondaire",
    "DIRETP",
    "SECOPE",
    "SERNIE",
    ""
  ];
  //
  RxInt i = 0.obs;
  //
  RxInt i2 = 0.obs;
  //
  List<String> listeTiquet = [
    "Gratuité de l'enseignement",
    "Violences basées sur le genre",
    "Diplome d'état",
    "Examen d'état",
    "TENAFEP",
    "TENASOP",
    "Suspension",
    "Salaire ou prime",
    "Matricule",
    "Autres...",
  ];
  //
  String ext1 = "png";
  String ext2 = "png";
  //
  DepotController depotController = Get.find();
  //
  XFile? img1;
  XFile? img2;
  RxBool piecejointe = false.obs;
  RxString piecejointe_text = "".obs;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    listeDistrict.clear();
    //
    for (var element in listeDistrict2) {
      if ("${element['p']}".toLowerCase() ==
          ("${listeProvince[0]}".toLowerCase())) {
        listeDistrict.add("${element['d']}");
      }
    }
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.titre!,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
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
              const Text("Identité agent EPST"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nom,
                decoration: InputDecoration(
                  //prefixIcon: Text("De:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("Nom"),
                  //prefixText: "De: "
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: postnom,
                decoration: InputDecoration(
                    //prefixIcon: Text("Téléphone:"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    label: const Text("Postnom")
                    //prefixText: "De: "
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: prenom,
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("Prenom"),
                  //prefixText: "De: "
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: matricule,
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("Matricule SECOPE"),
                  //prefixText: "De: "
                ),
              ),
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
                      const Text(
                        "  Direction:",
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
                            /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                            isExpanded: true,
                            onChanged: (value) {
                              a = value as int;
                              print("le id: $a");
                            },
                            items: List.generate(
                              listeDiraction.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeDiraction[index]),
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
                height: 10,
              ),
              const Text("Services"),
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
                      const Text("  Sevices:"),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: s,
                            onChanged: (value) {
                              s = value as int;
                              setState(() {
                                if (s == 0) {
                                  piecejointe = false.obs;
                                  piecejointe_text.value = "";
                                } else if (s == 1) {
                                  piecejointe_text.value = "Note de transfère";
                                  piecejointe = true.obs;
                                } else {
                                  piecejointe_text.value = "Odonnance";
                                  piecejointe = true.obs;
                                }
                              });
                              //value = s;
                            },
                            items: List.generate(
                              listeServices.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeServices[index]),
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
              ////////////////////:
              const SizedBox(
                height: 10,
              ),
              const Text("Province"),
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
                              p = value as int;
                              listeDistrict.clear();
                              setState(() {
                                for (var element in listeDistrict2) {
                                  if ("${element['p']}".toLowerCase() ==
                                      ("${listeProvince[p]}".toLowerCase())) {
                                    print("$element");
                                    listeDistrict.add("${element['d']}");
                                  }
                                }
                              });
                              //value = s;
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
              ///////////
              const SizedBox(
                height: 10,
              ),
              const Text("Province éducationnel"),
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
                      const Text("  Province éducationnel:"),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: d,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              d = value as int;
                              setState(() {});
                              //value = s;
                            },
                            items: List.generate(
                              listeDistrict.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeDistrict[index]),
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
              ///////////
              const SizedBox(
                height: 10,
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
                  height: MediaQuery.of(context).size.height / 8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: notes,
                          //maxLength: 10,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: "  Hopital et/ou Médicaments solicités",
                            border: InputBorder.none,
                            //prefixText: "De: "
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
                      const Text("  Bénéficières:"),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: b,
                            onChanged: (value) {
                              value = b;
                            },
                            items: List.generate(
                              listeBeneficiaire.length,
                              (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(listeBeneficiaire[index]),
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
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  // Pick an image
                  img1 = await picker.pickImage(source: ImageSource.gallery);
                  ext1 = img1!.name.split(".").last;
                  i = 1.obs;
                  print("ext ${img1!.name}".split(".").last);
                  // Capture a photo
                  Timer(const Duration(seconds: 1), () {
                    setState(() {
                      //
                    });
                  });
                },
                icon: const Icon(Icons.file_present),
                label: const Text("Joindre la carte MESP du bénéficiaire"),
              ),
              Obx(() => i.value != 0
                  ? Container(
                      height: Get.size.height / 4,
                      width: Get.size.width / 1.1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(img1!.path)))),
                      //child: Image.file(File(img!.path)),
                    )
                  : Container()),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => piecejointe.value
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image
                          img2 = await picker.pickImage(
                              source: ImageSource.gallery);
                          ext2 = img2!.name.split(".").last;
                          i2 = 1.obs;
                          print("ext ${img2!.name}".split(".").last);
                          // Capture a photo
                          Timer(const Duration(seconds: 1), () {
                            setState(() {
                              //
                            });
                          });
                        },
                        icon: const Icon(Icons.file_present),
                        label: Text(piecejointe_text.value),
                      )
                    : Container(),
              ),
              Obx(() => i2.value != 0
                  ? Container(
                      height: Get.size.height / 4,
                      width: Get.size.width / 1.1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(img2!.path)))),
                      //child: Image.file(File(img!.path)),
                    )
                  : Container()),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nom.text.isEmpty) {
                    messageErreur("Erreur", "Veuillez remplire le champ nom");
                  } else if (postnom.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ postnom");
                  } else if (prenom.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ prenom");
                  } else if (matricule.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ matricule");
                  } else if (notes.text.isEmpty) {
                    messageErreur("Erreur", "Veuillez remplire le champ notes");
                  } else if (notes.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez associer la photo de la carte");
                  } else {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    //
                    if (connectivityResult
                            .contains(ConnectivityResult.mobile) ||
                        connectivityResult.contains(ConnectivityResult.wifi)) {
                      //
                      Get.dialog(Center(
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
                      ));
                      //
                      //Future<Uint8List> i = img1!.readAsBytes();
                      //File file = File(img1!.path);
                      //
                      Uint8List l1 = await img1!.readAsBytes();
                      Uint8List l2 = img2 != null
                          ? await img2!.readAsBytes()
                          : Uint8List.fromList([1]);

                      //
                      Map<String, dynamic> formulaireD = {
                        //"id": getCode(),
                        "nom": nom.text,
                        "postnom": postnom.text,
                        "prenom": prenom.text,
                        "matricule": matricule.text,
                        "direction": listeDiraction[a],
                        "services": listeServices[s],
                        "beneficiaire": listeBeneficiaire[b],
                        "notes": notes.text,
                        "jour": "${DateTime.now()}",
                        "valider": 0,
                        "carte": l1,
                        "piecejointe": l2,
                        "ext1": ext1,
                        "ext2": ext2,
                        "province": listeProvince[p],
                        "district": listeDistrict[d]
                      };
                      //
                      MutuelleController mutuelleController = Get.find();
                      //ByteArrayInputStream//formulaireD
                      //
                      Timer(const Duration(seconds: 1), () {
                        mutuelleController.faireUnDemande(formulaireD);
                      });

                      //____________________________________________________________
                    } else {}
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

  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
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

class PlainteHis extends StatefulWidget {
  const PlainteHis({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlainteHis();
  }
}

class _PlainteHis extends State<PlainteHis> {
  Future<Widget> getPlaite() async {
    Historique historique = Historique();
    Database? db = await historique.openDB();
    //
    List<Map<String, dynamic>> listPlainte =
        await db.rawQuery('SELECT * FROM historique');

    return ListView(
      padding: const EdgeInsets.all(10),
      children: List.generate(
        listPlainte.length,
        (index) {
          print(listPlainte[index]["envoyer"]);
          return ListTile(
            onTap: () {
              //
              if (listPlainte[index]["envoyer"] == "non") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HistoriqueSend(listPlainte[index]);
                    },
                  ),
                );
              }
            },
            leading: const Icon(Icons.menu),
            title: Text(listPlainte[index]["envoyeur"]),
            subtitle: Text(listPlainte[index]["date"]),
            trailing: listPlainte[index]["envoyer"] == "non"
                ? const Icon(Icons.sync)
                : const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
      ),
      body: FutureBuilder(
        future: getPlaite(),
        builder: (context, b) {
          if (b.hasData) {
            return b.data as Widget;
          } else if (b.hasError) {
            return Center(
              child: Text("Erreur lors du chargement: ${b.error}"),
            );
          }
          return Center(
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class HistoriqueSend extends StatefulWidget {
  Map<String, dynamic> pl = {};

  HistoriqueSend(this.pl, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoriqueSend();
  }
}

class _HistoriqueSend extends State<HistoriqueSend> {
  //
  DepotController depotController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          Text.rich(
            TextSpan(
              text: "De: ",
              style: st,
              children: [
                TextSpan(
                  text: "${widget.pl['envoyeur']}",
                  style: st2,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Téléphone: ",
              style: st,
              children: [
                TextSpan(
                  text: "${widget.pl['telephone']}",
                  style: st2,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Email: ",
              style: st,
              children: [
                TextSpan(
                  text: "${widget.pl['email']}",
                  style: st2,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "À: ",
              style: st,
              children: [
                TextSpan(
                  text: "${widget.pl['destinateur']}",
                  style: st2,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Message: \n",
              style: st,
              children: [
                TextSpan(
                  text: "${widget.pl['message']}^n\n",
                  style: st2,
                ),
              ],
            ),
          ),
          Container(
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
                    //child: Text(Fichier),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (e) {
                    //getFile();
                  },
                  icon: const Icon(
                    Icons.attach_file,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        getFile();
                      },
                      value: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.file_copy_outlined),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Piece jointe",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  List.generate(depotController.listeFichier.value.length, (x) {
                return ListTile(
                  leading: const Icon(Icons.file_present),
                  title: Text("Piece n° $x"),
                  trailing: IconButton(
                    onPressed: () {
                      //
                      setState(() {
                        depotController.listeFichier.value.removeAt(x);
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
              //
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              //
              if (connectivityResult.contains(ConnectivityResult.mobile) ||
                  connectivityResult.contains(ConnectivityResult.wifi)) {
                // I am connected to a mobile network. I am connected to a wifi network.
                //
                //widget.pl["envoyer"] = "oui";
                Map<String, dynamic> utilisateur = widget.pl;
                utilisateur["envoyer"] = "oui";
                // deC.clear();
                // telephoneC.clear();
                // emailC.clear();
                // aC.clear();
                // messageC.clear();
                // a = 0;
                // p = 0;
                print("_____________________: $utilisateur");
                List<Map<String, dynamic>> l = [];
                /*
                      //____________________________________________________________
                      depotController.listeFichier.value.forEach((element) {
                        Map<String, dynamic> e = element;
                        l.add(e);
                      });
                      */
                //____________________________________________________________
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Transfere1(utilisateur, l);
                    },
                  ),
                );
              } else {
                //GetSnackBar(title: titre, message: message);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Problème de connexion"),
                      content: const Text(
                        "Vous n'etes pas connecté à internet, veuillez vous reconnecter puis reessayer",
                        textAlign: TextAlign.center,
                      ),
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
            },
            child: const Text("Reenvoyer"),
          ),
        ],
      ),
    );
  }

  var st = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: Colors.black,
  );

  var st2 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: Colors.green,
  );

  getFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      files.forEach((element) async {
        //
        List<String> extT = element.path.split(".");
        String ext = extT.last;
        Uint8List l = await element.readAsBytes();
        depotController.listeFichier.value.add(
          {
            "length": l.length,
            "data": l,
            "type": ext,
          },
        );
      });
      setState(() {});
    } else {
      // User canceled the picker
    }
  }
}
