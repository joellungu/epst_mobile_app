import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/vues/transsfere.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DepotPlainte extends StatefulWidget {
  String? titre;

  DepotPlainte({this.titre});

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
  List listeTiquet = [
    "Gratuité de l'enseignement",
    "Violences basées sur le genre",
    "Autres...",
  ];
  //
  List<Map<String, dynamic>> listeFichier = [];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.history),
                        Text("  Historique")
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.history),
                        Text("  References")
                      ],
                    ),
                  )
                ],
                onChanged: (e) {
                  if (e == 1) {
                    //
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlainteHis(),
                      ),
                    );
                  } else {
                    /*
              //
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlainteHis(),
                ),
              );
              */
                  }
                },
              ),
            ),
          )
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
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: Text("De:"),
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
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    label: Text("Téléphone:")
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
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: Text("Email:"),
                  //prefixText: "De: "
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: aC,
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: Text("À:"),
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
                      Text("  Province:"),
                      SizedBox(
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
                      Text("  Tiquet:"),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            value: a,
                            onChanged: (value) {
                              value = a;
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
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: messageC,
                          //maxLength: 10,
                          maxLines: 5,
                          decoration: InputDecoration(
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
                                  child: Text(Fichier),
                                ),
                              ),
                              PopupMenuButton(
                                onSelected: (e) {
                                  getFile();
                                },
                                icon: Icon(
                                  Icons.attach_file,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      //getFile();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Icon(Icons.file_copy_outlined),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Document",
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
                                  PopupMenuItem(
                                    onTap: () {
                                      //getFile();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Icon(
                                            Icons.photo_album_outlined,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Multimedia",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    onTap: () async {
                                      //
                                      //getFile();
                                      /*
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? video =
                                          await _picker.pickVideo(
                                        source: ImageSource.camera,
                                      );
                                      */
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Icon(Icons.video_camera_back),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Videos",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Icon(Icons.audiotrack),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Voie",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                    value: 1,
                                  ),
                                ],
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
              ElevatedButton(
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  //
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    // I am connected to a mobile network. I am connected to a wifi network.
                    //
                    Map<String, dynamic> utilisateur = {
                      "envoyeur": deC.text,
                      "telephone": telephoneC.text,
                      "email": emailC.text,
                      "destinateur": deC.text,
                      "id_tiquet": a,
                      "message": messageC.text,
                      "id_statut": "${listeTiquet[a]}",
                      "piecejointe_id": "",
                      "reference": getReference(),
                      "date": "${DateTime.now()}",
                      "province": "${listeProvince[p]}",
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Transfere1(utilisateur, listeFichier);
                        },
                      ),
                    );
                  } else {
                    var ref = getReference();
                    Map<String, dynamic> utilisateur = {
                      "envoyeur": deC.text,
                      "telephone": telephoneC.text,
                      "email": emailC.text,
                      "destinateur": deC.text,
                      "id_tiquet": a,
                      "message": messageC.text,
                      "id_statut": "0",
                      "piecejointe_id": "",
                      "reference": ref,
                      "date": "${DateTime.now()}",
                      "province": "${listeProvince[p]}",
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
                    _createFolderAndSave(ref, listeFichier);
                    //
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Problème de connexion"),
                          content: const Text(
                              "Plainte enregitrée et sera envoyée plus tard."),
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

  String getReference() {
    List al = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    ];
    Random r = Random(25);
    int t1 = r.nextInt(25);
    int t2 = r.nextInt(25);
    int t3 = r.nextInt(25);
    int t4 = r.nextInt(25);
    int t5 = r.nextInt(25);
    int t6 = r.nextInt(25);
    int t7 = r.nextInt(25);
    String t8 = al[r.nextInt(25)];
    String t9 = al[r.nextInt(25)];
    String t10 = al[r.nextInt(25)];
    String t11 = al[r.nextInt(25)];
    String t12 = al[r.nextInt(25)];
    String t13 = al[r.nextInt(25)];
    String t14 = al[r.nextInt(25)];

    return "$t1$t2$t3$t4$t5$t6$t7$t8$t9$t10$t11$t12$t13$t14";
  }

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
        listeFichier.add(
          {
            "length": l.length,
            "data": l,
            "type": ext,
          },
        );
      });
    } else {
      // User canceled the picker
    }
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
    List<Map> listPlainte = await db.rawQuery('SELECT * FROM historique');

    return ListView(
      padding: EdgeInsets.all(10),
      children: List.generate(listPlainte.length, (index) {
        return ListTile(
          leading: Icon(Icons.menu),
          title: Text(listPlainte[index]["envoyeur"]),
          subtitle: Text(listPlainte[index]["date"]),
          trailing: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.sync),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
