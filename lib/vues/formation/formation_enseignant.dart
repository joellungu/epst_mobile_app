import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FormationEnseignent extends StatefulWidget {
  String? titre;

  FormationEnseignent({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _FormationEnseignent();
  }
}

class _FormationEnseignent extends State<FormationEnseignent> {
  List actus = [
    "Maternelle",
    "Primaire",
    "Secondaire Général",
    "Humanité",
    "Autre"
  ];
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: ListView(
        children: List.generate(actus.length, (index) {
          return ListTile(
            onTap: () {
              print("$index");
              if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Lire(
                      titre: "${actus[index]}",
                    ),
                  ),
                );
              }
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PdfVue(
                    titre: "LE MAGAZINE DE L'EPST 4  01.12.2021",
                  ),
                ),
              );
              */
            },
            leading: Icon(
              Icons.school,
              color: Colors.black,
            ),
            title: Text(
              "${actus[index]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(" Mise à jour le 12/12/2022"),
          );
        }),
      ),
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