import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Actualite extends StatefulWidget {
  String? titre;

  Actualite({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Actualite();
  }
}

class _Actualite extends State<Actualite> {
  Stream<int> tcheck() async* {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print(
            '_________________________________________________________________connected');

        var url = Uri.parse('https://www.google.com');
        //var client = HttpClient();

        while (true) {
          //var response = await http.get(url);
          //HttpClientRequest request =
          //await client.get('www.google.com', 80, '');
          Future.delayed(
            Duration(seconds: 5),
          );
          //Optionally set up headers...
          //Optionally write to the request object...
          //HttpClientResponse response = await request.close();
          //print('Response status: ${result.statusCode}');
          yield 200; //response.statusCode;
        }
      }
    } on SocketException catch (_) {
      print(
          '___________________________________________________________________not connected');
      yield 0;
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: tcheck(),
        builder: (context, e) {
          switch (e.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Container(
                  height: 5,
                  width: 100,
                  alignment: Alignment.center,
                  child: LinearProgressIndicator(),
                ),
              );
            case ConnectionState.none:
              return const Center(
                child: Center(
                  child: Text("Un probleme lors de connexion"),
                ),
              );
            case ConnectionState.active:
              if (e.data == 0) {
                return Container(
                  color: Colors.blueGrey,
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: 'https://www.eduquepsp.education/',
                  ),
                );
              }
            case ConnectionState.done:
              if (e.data == 0) {
                return Center(
                    child: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 100,
                      ),
                      Text("Vous n'etes pas connecté au reseau!"),
                    ],
                  ),
                ));
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: 'https://www.eduquepsp.education/',
                  ),
                );
              }
          }
        },
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