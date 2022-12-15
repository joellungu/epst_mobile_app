import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/recherche_ecole.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DemandeTransfere extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemandeTransfere();
  }
}

class _DemandeTransfere extends State<DemandeTransfere> {
  WebViewController? controlleur;

  TextEditingController nom = TextEditingController();
  TextEditingController postnom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController nom_pere = TextEditingController();
  TextEditingController nom_mere = TextEditingController();
  TextEditingController filiere_avant = TextEditingController();
  TextEditingController filiere_apres = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController lieu_de_naissance = TextEditingController();
  List genres = ["Homme", "Femme"];
  int genre = 0;
  List listeProvince = [
    "Bas-Uele",
    "Équateur",
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
  int p = 9;
  //
  String ext1 = "png";
  RxInt i = 0.obs;
  XFile? img1;
  //
  DateTime? d;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande note acquis de droit"),
      ),
      body: false
          ? WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController w) {
                controlleur = w;
              },
              initialUrl:
                  "https://www.eduquepsp.education", //https://www.youtube.com
              //"https://www.efoad.minepst.gouv.cd",
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  const Text("Informations personnel"),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nom,
                    decoration: InputDecoration(
                      //prefixIcon: Text("De:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Nom"),
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
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        label: Text("Postnom")
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
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Prenom"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "  Genre:",
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<int>(
                                value: genre,
                                /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                                isExpanded: true,
                                onChanged: (value) {
                                  genre = value as int;
                                  print("le id: $genre");
                                },
                                items: List.generate(
                                  genres.length,
                                  (index) {
                                    return DropdownMenuItem(
                                      value: index,
                                      child: Text(genres[index]),
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
                  TextField(
                    controller: lieu_de_naissance,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Lieu de naissance"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Date de naissance"),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          d == null
                              ? Text("  Date de naissance: ")
                              : Text(
                                  "  Date de naissance: ${d!.day}/${d!.month}/${d!.year}"),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2090),
                                    ).then((value) {
                                      setState(() {
                                        d = value;
                                      });
                                    });
                                  },
                                  icon: const Icon(Icons.date_range),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nom_pere,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Nom père"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nom_mere,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Nom mère"),
                      //prefixText: "De: "
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: filiere_avant,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("filiere avant"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: filiere_apres,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Filière apres"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("  Province d'origine:"),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<int>(
                                value: p,
                                onChanged: (value) {
                                  p = value as int;
                                  //listeDistrict.clear();
                                  setState(() {});
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
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Ecole provenance"),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: InkWell(
                      onTap: () {
                        //
                        showSearch(
                            context: context, delegate: RechercheEcole());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          //width: Get.size.width,
                          child: Obx(
                            () => Text(
                              ecole1.value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Ecole destination"),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: InkWell(
                      onTap: () {
                        //
                        showSearch(
                            context: context, delegate: RechercheEcole());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          //width: Get.size.width,
                          child: Obx(
                            () => Text(
                              ecole2.value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: telephone,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Numéro de téléphone"),
                      //prefixText: "De: "
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: adresse,
                    decoration: InputDecoration(
                      //prefixIcon: Text("Email:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      label: Text("Adresse"),
                      //prefixText: "De: "
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image
                      img1 =
                          await _picker.pickImage(source: ImageSource.gallery);
                      ext1 = "${img1!.name}".split(".").last;
                      i = 1.obs;
                      print("ext ${img1!.name}".split(".").last);
                      // Capture a photo
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          //
                        });
                      });
                    },
                    icon: Icon(Icons.file_present),
                    label: Text("Joindre la carte MESP du bénéficiaire"),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (nom.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ nom");
                      } else if (postnom.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ postnom");
                      } else if (prenom.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ prenom");
                      } else if (nom_pere.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ matricule");
                      } else if (nom_mere.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ notes");
                      } else if (adresse.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez associer la photo de la carte");
                      } else if (telephone.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ postnom");
                      } else if (prenom.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ prenom");
                      } else if (lieu_de_naissance.text.isEmpty) {
                        messageErreur(
                            "Erreur", "Veuillez remplire le champ matricule");
                      } else {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        //
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          //
                          Get.dialog(Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CircularProgressIndicator(
                                strokeWidth: 7,
                              ),
                            ),
                          ));
                          //
                          //Future<Uint8List> i = img1!.readAsBytes();
                          //File file = File(img1!.path);
                          //
                          Uint8List l1 = await img1!.readAsBytes();

                          //
                          Map<String, dynamic> formulaireD = {
                            "id": getCode(),
                            "nom": nom.text,
                            "postnom": postnom.text,
                            "prenom": prenom.text,
                            "nompere": nom_pere.text,
                            "nommere": nom_mere.text,
                            "telephone": telephone.text,
                            "adresse": adresse.text,
                            "datenaissance": "${d!.day}/${d!.month}/${d!.year}",
                            "sexe": genres[genre],
                            "photo": l1,
                            "ext1": ext1,
                            "province": listeProvince[p],
                          };
                          //
                          // MutuelleController mutuelleController = Get.find();
                          // //ByteArrayInputStream//formulaireD
                          // //
                          // Timer(Duration(seconds: 1), () {
                          //   mutuelleController.faireUnDemande(formulaireD);
                          // });

                          //____________________________________________________________
                        } else {}
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text("Envoyer"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controlleur!.reload();
      //   },
      //   child: Icon(Icons.sync),
      // ),
    );
  }

  //
  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
  }

  //
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
              icon: Icon(
                Icons.close,
              ),
            )
          ],
        );
      },
    );
  }
}
