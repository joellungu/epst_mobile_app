import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController w) {
          controlleur = w;
        },
        initialUrl:
            "https://www.eductv.cd/all_actualite.php", //https://www.youtube.com
        //"https://www.eduquepsp.education/v1/category/actualites/",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controlleur!.reload();
          });
        },
        child: Icon(Icons.sync),
      ),
    );
  }
}
