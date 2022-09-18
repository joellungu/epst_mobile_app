import 'package:epst_app/vues/actualite/site.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'clin_oeil.dart';
import 'direct_eductivi.dart';

class LiveStream extends StatefulWidget {
  String? titre;
  LiveStream({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _LiveStream();
  }
}

class _LiveStream extends State<LiveStream> {
  WebViewController? controlleur;
  /*
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'jVYG_eH5UMU',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  */

  @override
  void initState() {
    //
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitUp ]);
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return DirectEductivi();
                  },
                ),
              );
            },
            style: ButtonStyle(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.live_tv,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "direct",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ClinOeil();
                  },
                ),
              );
            },
            style: ButtonStyle(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove_red_eye,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "Clin oeil",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Site();
                  },
                ),
              );
            },
            style: ButtonStyle(
                /*
              backgroundColor: MaterialStateProperty.all(
                Colors.blue.shade400,
              ),
              */
                ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.language,
                        size: 100,
                      ), //
                      decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "actualité site",
                          children: [
                            TextSpan(
                              text: "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
