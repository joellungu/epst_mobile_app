import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerificationDocument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerificationDocument();
  }
}

class _VerificationDocument extends State<VerificationDocument> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande note acquis de droit"),
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
