import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FOAD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FOAD();
  }
}

class _FOAD extends State<FOAD> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOAD"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController w) {
          controlleur = w;
        },
        initialUrl:
            //"https://www.eductv.cd/all_actualite.php", //https://www.youtube.com
            "https://www.efoad.minepst.gouv.cd",
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
