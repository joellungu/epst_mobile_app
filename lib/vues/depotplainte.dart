import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DepotPlainte extends StatefulWidget {
  String? titre;

  DepotPlainte({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _DepotPlainte();
  }
}

class _DepotPlainte extends State<DepotPlainte> {
  bool exp = false;
  int a = 1;
  var Fichier = "";
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                  //prefixIcon: Text("De:"),
                  label: Text("De:"),
                  //prefixText: "De: "
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    //prefixIcon: Text("Téléphone:"),
                    label: Text("Téléphone:")
                    //prefixText: "De: "
                    ),
              ),
              TextField(
                decoration: InputDecoration(
                  //prefixIcon: Text("Email:"),
                  label: Text("Email:"),
                  //prefixText: "De: "
                ),
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<int>(
                value: a,
                onChanged: (value) {
                  value = a;
                },
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Text("Ministre"),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text("Secretaire General"),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text("Inspecteur General"),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text("DRH"),
                  )
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          //maxLength: 10,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "  Message",
                            border: InputBorder.none,
                            //prefixText: "De: "
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            //color: Colors.yellow,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(Fichier),
                                ),
                              ),
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.attach_file,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("First"),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text("Second"),
                                    value: 2,
                                  )
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    //
                                    //EasyPopup.show(context, CustomWidget());
                                    // File? file;
                                    // //
                                    // FilePickerResult? result =
                                    //     await FilePicker.platform.pickFiles();

                                    // if (result != null) {
                                    //   file = File(result.files.single.path!);
                                    // } else {
                                    //   // User canceled the picker
                                    // }
                                    // //
                                    // setState(() {
                                    //   Fichier = file!.path;
                                    // });
                                  },
                                  icon: Icon(
                                    Icons.attach_file,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("Envoyer"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("Tchat"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
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
