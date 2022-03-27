import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

var _channel;

class Chat extends StatefulWidget {
  String? titre;
  String? nom;

  Chat({this.titre, this.nom});
  @override
  State<StatefulWidget> createState() {
    return _Chat();
  }
}

class _Chat extends State<Chat> {
  List<Widget> listeConv = [];

  Widget? chatt;

  @override
  void initState() {
    //
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8080/chat/tatu'), //${widget.nom}192.168.43.2
    );
    //
    _channel.stream.listen((message) {
      //
      Map<String, dynamic> map = jsonDecode((message) as String);
      print("la reponse du serveur: $map");
      String idsession = map["idsession"] ?? map["requete"];

      //
      String idSessionHote = map["idSessionHote"] ?? "";
      //
      String contenu = map["contenu"] ?? "";
      contenu != "" ? listeConv.add(smsMessage(false, contenu)) : "";
      setState(() {
        if (idsession == "start") {
          chatt = ChattConv(idSessionHote, listeConv);
        }
      });
    });

    print(_channel);
    chatt = Center(
      child: Container(
        height: 100,
        //width: 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 5,
              width: 100,
              alignment: Alignment.center,
              child: LinearProgressIndicator(),
            ),
            Text("Etablissement de la communication avec un agent de la DGC")
          ],
        ),
      ),
    );

    //
    super.initState();
  }

  @override
  void dispose() {
    //_channel.closeReason = "";
    _channel.sink.close(0);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Agent DGC/EPST"),
            ],
          ),
        ),
        body: chatt!);
  }

  Widget smsMessage(bool t, String contenu) {
    if (t) {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            contenu,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            contenu,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}

class ChattConv extends StatefulWidget {
  List? listeConv;
  String? idSessionHote;

  ChattConv(this.idSessionHote, this.listeConv);

  @override
  State<StatefulWidget> createState() {
    return _ChattConv();
  }
}

class _ChattConv extends State<ChattConv> {
  TextEditingController chatCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView(
            children: List.generate(
              widget.listeConv!.length,
              (index) {
                return widget.listeConv![index];
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.mic,
                  color: Colors.green.shade300,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    //height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file,
                            color: Colors.blue.shade400,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: chatCont,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            //
                            setState(() {
                              widget.listeConv!
                                  .add(smsMessage(true, chatCont.text));
                              _channel.sink.add(
                                  """{"from":"...","to":"${widget.idSessionHote}","content":"${chatCont.text}" }""");
                              chatCont.clear();
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget smsMessage(bool t, String contenu) {
    if (t) {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            contenu,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            contenu,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}
