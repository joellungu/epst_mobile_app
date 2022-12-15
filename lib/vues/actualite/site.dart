import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Actualites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Actualites();
  }
}

class _Actualites extends State<Actualites> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualité"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController w) {
          controlleur = w;
        },
        initialUrl: "https://www.eduquepsp.education", //https://www.youtube.com
        //"https://www.efoad.minepst.gouv.cd",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controlleur!.reload();
        },
        child: Icon(Icons.sync),
      ),
    );
  }
}
