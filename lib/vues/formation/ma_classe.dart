import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MaClasse extends StatefulWidget {
  const MaClasse({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MaClasse();
  }
}

class _MaClasse extends State<MaClasse> {
  WebViewController? controlleur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enseignement à distance"),
      ),
      // body: WebView(
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController w) {
      //     controlleur = w;
      //   },
      //   initialUrl:
      //       //"https://www.eductv.cd/all_actualite.php", //https://www.youtube.com
      //       "https://www.cd-maclasse.com",
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controlleur!.reload();
        },
        child: const Icon(Icons.sync),
      ),
    );
  }
}
