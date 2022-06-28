import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/models/reforme.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Actualite extends StatefulWidget {
  String? titre;

  Actualite({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Actualite();
  }
}

class _Actualite extends State<Actualite> {
  //
  var box = GetStorage();
  //
  List actus = [
    "Gratuité de l'enseignement",
    "Programme scolaire Maternelle",
    "Apprentissage des maths (PEQPSU)",
    "Amelioration de la qualité de l'enseignement (PAQUED)",
    "PERSE"
  ];
  @override
  void initState() {
    loadMagasin();
    //
    super.initState();
  }

  RxBool loads = true.obs;
  //
  List liste = [];
  //
  Future<void> loadMagasin() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      bool v = await Connexion.liste_magasin(2);
      //liste = await
      liste = box.read("reforme");
      loads.value = v;
    } else {
      liste = box.read("reforme");
      loads.value = false;
    }

    //
    print("longueur  ___  $liste");

  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
        body: Obx(()=> loads.value ?
        Center(
          child: Container(height: 40, width: 40, alignment: Alignment.center,
            child: CircularProgressIndicator(),),
        )
            : ListView(
          children: List.generate(liste.length, (index) {
            return ListTile(
              onTap: () async {
                final Directory directory =
                await getApplicationDocumentsDirectory();
                //
                print(
                    "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
                //
                File f = await File("${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}")
                    .writeAsBytes(box.read("${liste[index]["id"]}"));
                print(box.read("${liste[index]["id"]}"));

                OpenResult or = await OpenFile.open(
                    "${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}");
                print(or.message);
                print(or.type);
              },
              leading: Icon(
                Icons.file_copy_rounded,
                color: Colors.black,
              ),
              title: Text(liste[index]["libelle"]),
              subtitle: Text(liste[index]["date"]),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            );
          }),
        ))
    );
  }
}

class Lire extends StatefulWidget {
  String? titre;

  Lire({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Lire();
  }
}

class _Lire extends State<Lire> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '74EdyJzluWY',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}


//https://www.eduquepsp.education/
/*
ListView(
        padding: EdgeInsets.only(
          top: 20,
        ),
        children: List.generate(100, (index) {
          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PdfVue(
              //       titre: "DYG  duy UYd  DUQY uysd",
              //     ),
              //   ),
              // );
            },
            child: Card(
              elevation: 0,
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.photo_album,
                          size: MediaQuery.of(context).size.width / 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                """Nostrud officia ut irure commodo excepteur. Velit occaecat dolore sunt cupidatat exercitation. Aliquip incididunt amet exercitation anim commodo tempor enim ullamco aliquip. Nulla cillum occaecat cillum duis ipsum fugiat occaecat pariatur esse irure adipisicing. Elit duis id fugiat aliqua est. Irure occaecat qui ipsum amet amet est sint magna nisi quis duis id occaecat cupidatat. Laborum sunt consectetur in fugiat nisi.""",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "12/12/2022",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
*/