import 'package:epst_app/vues/actualite/site.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'clin_oeil.dart';
import 'dinacope.dart';
import 'direct_eductivi.dart';

class LiveStream extends StatefulWidget {
  String? titre;
  LiveStream({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LiveStream();
  }
}

class _LiveStream extends State<LiveStream> {
  WebViewController? controlleur;
  //
  double st = 12;
  double taille = 8;
  double pd = 13;
  //
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
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
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.7,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const DirectEductivi();
                    },
                  ),
                );
              },
              style: const ButtonStyle(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        alignment: Alignment.center, //
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.live_tv,
                          size: 100,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Direct",
                            children: [
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  fontSize: taille,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: st,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
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
                      return const ClinOeil();
                    },
                  ),
                );
              },
              style: const ButtonStyle(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        alignment: Alignment.center, //
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove_red_eye,
                          size: 100,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Clin d'œil ",
                            children: [
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  fontSize: taille,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: st,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
                Get.to(const Actualites());
                /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Actualites();
                  },
                ),
              );
              */
              },
              style: const ButtonStyle(
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
                        alignment: Alignment.center, //
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.language,
                          size: 100,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Educ-NC sur le net",
                            children: [
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  fontSize: taille,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: st,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
                Get.to(
                  const Dinacope(),
                );
                /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Actualites();
                  },
                ),
              );
              */
              },
              style: const ButtonStyle(
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
                        alignment: Alignment.center, //
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          image: DecorationImage(
                            image:
                                ExactAssetImage("assets/dinacope_blanc_nv.png"),
                            fit: BoxFit.contain,
                            colorFilter:
                                ColorFilter.mode(Colors.blue, BlendMode.color),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        // child: const Icon(
                        //   Icons.language,
                        //   size: 100,
                        //   color: Colors.blue,
                        // ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "DINACOPE",
                            children: [
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  fontSize: taille,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: st,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            /*
          
          */
          ],
        ),
      ),
    );
  }
}
