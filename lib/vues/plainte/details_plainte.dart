import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'transsfere.dart';

// ignore: must_be_immutable
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
  //
  var box = GetStorage();
  //
  //List listeFichierSave = [];
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Timer(const Duration(microseconds: 500), () {
      depotController.listeFichier.value =
          box.read(widget.pl["reference"]) ?? [];
    });
  }

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
                  text: "${widget.pl['message']}\n",
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
              children: List.generate(depotController.listeFichier.length, (x) {
                return ListTile(
                  leading: const Icon(Icons.file_present),
                  title: Text("Piece n° $x"),
                  trailing: IconButton(
                    onPressed: () {
                      //
                      setState(() {
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
              //
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              //
              // ignore: unrelated_type_equality_checks
              if (connectivityResult.contains(ConnectivityResult.mobile) ||
                  // ignore: unrelated_type_equality_checks
                  connectivityResult.contains(ConnectivityResult.wifi) ||
                  connectivityResult.contains(ConnectivityResult.ethernet)) {
                // I am connected to a mobile network. I am connected to a wifi network.
                //
                //widget.pl["envoyer"] = "oui";
                Map<String, dynamic> utilisateur = {};
                utilisateur.addAll(widget.pl);
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

                //____________________________________________________________
                for (var element in depotController.listeFichier) {
                  // Map<String, dynamic> e = element;
                  print("element:  $element");
                  // l.add(e);
                  List<String> extT = element.split(".");
                  String ext = extT.last;
                  String name = extT.first;
                  File f = File(element);
                  Uint8List lu = f.readAsBytesSync();
                  //
                  l.add({
                    "length": lu.length,
                    "data": lu,
                    "type": ext,
                    "name": name,
                  });
                }

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
        depotController.listeFichier.add(
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
