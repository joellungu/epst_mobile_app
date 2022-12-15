import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Listing extends StatefulWidget {
  String? titre;

  Listing({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Listing();
  }
}

class _Listing extends State<Listing> {
  bool exp = false;
  int a = 1;
  WebViewController? controlleur;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: Padding(
          padding: EdgeInsets.only(
              //bottom: 20,
              ),
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController w) {
              controlleur = w;
            },
            //http://www.dgpardc.org/
            //https://www.secoperdc.com/
            initialUrl: "http://www.secoperdc.com", //https://www.youtube.com
            //"https://www.eduquepsp.education/v1/category/actualites/",
          ),
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


/*
SizedBox(height: 20,),
              Container(height: 50,
              child: Flexible(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 25.0,
                    maxHeight: 135.0,
                  ),
                  child: new Scrollbar(
                    child: new TextField(
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //controller: tc,
                      //_handleSubmitted : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 2.0,
                            left: 13.0,
                            right: 13.0,
                            bottom: 2.0),
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                          color:Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ),
 */