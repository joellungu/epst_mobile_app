import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/reference.dart';
import 'package:epst_app/vues/transsfere.dart';
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

  Demande({this.titre});

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

  int a = 0;
  int s = 0;
  int b = 0;
  var Fichier = "";
  List listeProvince = [
    "Bas-Uele",
    "Équateur",
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

  List listeServices = [
    "Demande consulation",
    "Demande transfère",
    "Demande médicaments",
    "",
  ];
  //
  List listeBeneficiaire = [
    "Moi-meme",
    "Epouse",
    "Enfant 1",
    "Enfant 2",
  ];
  //
  List listeDiraction = [
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
  List listeTiquet = [
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
  String ext = "png";
  //
  DepotController depotController = Get.find();
  //
  XFile? img;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!, style: TextStyle(fontSize: 17,),),
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
              Text("Identité agent EPST"),
              SizedBox(height: 10,),
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
              TextField(
                controller: matricule,
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: Text("Matricule SECOPE"),
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
                      Text("  Direction:",
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                      SizedBox(
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

              Text("Services"),
              SizedBox(height: 10,),
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
                      Text("  Sevices:"),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: s,
                            onChanged: (value) {
                              value = s;
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
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: notes,
                          //maxLength: 10,
                          maxLines: 3,
                          decoration: InputDecoration(
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
                      Text("  Bénéficières:"),
                      SizedBox(
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
              SizedBox(height: 10,),
              ElevatedButton.icon(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    img = await _picker.pickImage(source: ImageSource.gallery);
                    ext = "${img!.name}".split(".").last;
                    i = 1.obs;
                    print("ext ${img!.name}".split(".").last);
                    // Capture a photo
                    Timer(Duration(seconds: 1), () {
                      setState((){
                        //
                      });
                    });
                  },
                icon: Icon(Icons.file_present),
                label: Text("Joindre la carte MESP du bénéficiaire"),
              ),
              Obx(
                    () => i.value != 0 ? Container(
                          height: Get.size.height / 4,
                          width: Get.size.width / 1.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(img!.path))
                            )
                          ),
                          //child: Image.file(File(img!.path)),
                        ):Container()
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nom.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ nom");
                  } else if (postnom.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ postnom");
                  } else if (prenom.text.isEmpty) {
                    messageErreur("Erreur", "Veuillez remplire le champ prenom");
                  } else if (matricule.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ matricule");
                  } else if (notes.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez remplire le champ notes");
                  } else if (notes.text.isEmpty) {
                    messageErreur(
                        "Erreur", "Veuillez associer la photo de la carte");
                  } else {
                    var connectivityResult =
                    await (Connectivity().checkConnectivity());
                    //
                    if (connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi) {
                      //
                      Get.dialog(
                          Center(
                            child: Container(
                              height: 40,width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CircularProgressIndicator(
                                strokeWidth: 7,
                              ),
                            ),
                          )
                      );
                      //
                      Future<Uint8List> i = img!.readAsBytes();
                      File file = File(img!.path);
                      //
                      Uint8List l = await img!.readAsBytes();
                      //
                      Map<String, dynamic> formulaireD = {
                        "id":1,
                        "nom": nom.text,
                        "postnom": postnom.text,
                        "prenom": prenom.text,
                        "matricule": matricule.text,
                        "direction": listeDiraction[a],
                        "services": listeServices[s],
                        "beneficiaire": listeBeneficiaire[b],
                        "notes": notes.text,
                        "jour":"${DateTime.now()}",
                        "valider":0,
                        "carte": l,
                        "ext": ext
                      };
                      //
                      //
                      MutuelleController mutuelleController = Get.find();
                      //ByteArrayInputStream//formulaireD
                      //
                      Timer(Duration(seconds: 1), () {
                        mutuelleController.faireUnDemande(formulaireD);
                      });

                      //____________________________________________________________
                    } else {

                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("Envoyer"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
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
              icon: Icon(
                Icons.close,
              ),
            )
          ],
        );
      },
    );
  }

  String getReference() {
    var uuid = Uuid();
    return "${uuid.v4()}";
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
      padding: EdgeInsets.all(10),
      children: List.generate(listPlainte.length, (index) {
        print(listPlainte[index]["envoyer"]);
        return ListTile(
          leading: Icon(Icons.menu),
          title: Text(listPlainte[index]["envoyeur"]),
          subtitle: Text(listPlainte[index]["date"]),
          trailing: IconButton(
            onPressed: () {
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
            icon: listPlainte[index]["envoyer"] == "non"
                ? Icon(Icons.sync)
                : Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique"),
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
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class HistoriqueSend extends StatefulWidget {
  Map<String, dynamic> pl = {};

  HistoriqueSend(this.pl);

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
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
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
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
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
                  icon: Icon(
                    Icons.attach_file,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        getFile();
                      },
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
                            child: Icon(Icons.file_copy_outlined),
                          ),
                          SizedBox(
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
                      value: 4,
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
                  leading: Icon(Icons.file_present),
                  title: Text("Piece n° $x"),
                  trailing: IconButton(
                    onPressed: () {
                      //
                      setState(() {
                        depotController.listeFichier.value.removeAt(x);
                      });
                      //
                    },
                    icon: Icon(Icons.close),
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
              if (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi) {
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
                      title: Text("Problème de connexion"),
                      content: Text(
                        "Vous n'etes pas connecté à internet, veuillez vous reconnecter puis reessayer",
                        textAlign: TextAlign.center,
                      ),
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
            },
            child: Text("Reenvoyer"),
          ),
        ],
      ),
    );
  }

  var st = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: Colors.black,
  );

  var st2 = TextStyle(
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
