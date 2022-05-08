import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel? _channel;
List<String> listeConSave = [];
Widget? chatt;
Widget? listChatt;

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
    //192.168.1.68
    //epstapp.herokuapp.com
    _channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://10.0.2.2:8080/chat/${widget.nom}/client'), //${widget.nom}192.168.43.2
    );
    //
    _channel!.stream.listen((message) {
      //
      Map<String, dynamic> map = jsonDecode((message) as String);
      print("la reponse du serveur: $map");
      //String idsession = map["idsession"] ?? map["requete"];

      //
      //String idSessionHote = map["idSessionHote"] ?? "";
      //
      String contenu = map["contenu"] ?? "";
      contenu != "" ? listeConv.add(smsMessage(false, contenu)) : "";
      setState(() {
        //
        //
        //String idSessionHote = map["idSessionHote"] ?? "";
        //
        String contenu = map["content"] ?? "";
        String hostId = map["hostId"] ?? "";
        String clientId = map["clientId"] ?? "";
        String from = map["from"] ?? "";
        String matricule = map["matricule"] ?? "";
        //String from = map["from"] ?? "";
        //
        if (map["conversation"] != true) {
          print("efface tout!");
          //listeConSave
          // Connexion.saveArchive({
          //   "date_save": "${DateTime.now()}",
          //   "nom_agent": "${widget.u!['postnom']} ${widget.u!['prenom']}",
          //   "nom_client": nomDe,
          //   "conversation": jsonEncode(listeConSave),
          // });
          listeConSave.clear();
          //
          listeConv.clear();
          listeConv.forEach((element) {
            bool v = listeConv.remove(element);
            v ? print("Effectué") : print("Pas éffectué");
          });
          chatt = Container();
        } else {
          listeConSave.add(contenu + "\n");
          contenu != "" ? listeConv.add(smsMessage(false, contenu)) : print("");
          //listeConv.add(smsMessage(false, contenu));
          chatt = ChattConv(
            "idSessionHote",
            listeConv,
            hostId,
            clientId,
            from,
            matricule,
            user: "${widget.nom}",
          );
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
    _channel!.closeCode;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                Navigator.of(context).pop();
                _channel!.sink.add(
                    """{"from":"","to":"","content":"","hostId":"","clientId":"","close":true,"all":false,"visible":"non","conversation": false,"matricule":"","date":"","heure":""}""");
              }),
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
        body: chatt!,
      ),
      onWillPop: () {
        _channel!.sink.add(
            """{"from":"","to":"","content":"","hostId":"","clientId":"","close":true,"all":false,"visible":"non","conversation": false,"matricule":"","date":"","heure":""}""");
        Navigator.of(context).pop();
        return Future.value(true);
      },
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

class ChattConv extends StatefulWidget {
  List? listeConv;
  String? idSessionHote;
  String? hostId, clientId, from;
  String? user;
  String? matricule;

  ChattConv(this.idSessionHote, this.listeConv, this.hostId, this.clientId,
      this.from, this.matricule,
      {this.user});

  @override
  State<StatefulWidget> createState() {
    return _ChattConv();
  }
}

class _ChattConv extends State<ChattConv> {
  TextEditingController chatCont = TextEditingController();
  //
  DateTime dateTime = DateTime.now();
  String date = "";
  String heure = "";

  @override
  void initState() {
    //
    date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    heure = "${dateTime.hour}:${dateTime.minute}";
    //
    //${dateTime.hour}
    //
    super.initState();
  }

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
                            print(
                                """{"from":"${widget.user}","to":"","content":"${chatCont.text}","hostId":"${widget.hostId}","clientId":"${widget.clientId}","close":false,"all":false,"visible":"non","conversation": true}""");
                            //
                            setState(() {
                              widget.listeConv!
                                  .add(smsMessage(true, chatCont.text));
                              _channel!.sink.add(
                                  """{"from":"${widget.user}","to":"","content":"${chatCont.text}","hostId":"${widget.hostId}","clientId":"${widget.clientId}","close":false,"all":false,"visible":"non","conversation": true,"matricule":"${widget.matricule}","date":"$date","heure":"$heure"}""");
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
//
