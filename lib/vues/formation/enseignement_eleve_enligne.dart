import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnseignementEleve extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnseignementEleve();
  }
}

class _EnseignementEleve extends State<EnseignementEleve> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enseignement à distance"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController w) {
          controlleur = w;
        },
        initialUrl:
        //"https://www.eductv.cd/all_actualite.php", //https://www.youtube.com
        "https://app.e-classerdc.com/login",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controlleur!.reload();
        },
        child: Icon(Icons.sync),
      ),
    );
  }
}
