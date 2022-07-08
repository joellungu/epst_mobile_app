import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Site extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Site();
  }
}

class _Site extends State<Site> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Site actualité"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController w) {
          controlleur = w;
        },
        initialUrl:
            //"https://www.eductv.cd/all_actualite.php", //https://www.youtube.com
            "https://www.eduquepsp.education/v1/",
      ),
    );
  }
}
