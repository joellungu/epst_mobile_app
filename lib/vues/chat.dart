import 'dart:convert';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel? _channel;
List<String> listeConSave = [];
Widget? chatt;
Widget? listChatt;

class Chat extends StatefulWidget {
  String? titre;
  String? nom;

  Chat({Key? key, this.titre, this.nom}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Chat();
  }
}

class _Chat extends State<Chat> {
  RxList<Widget> listeConv = RxList<Widget>();
  String contenu = "";
  String hostId = "";
  String clientId = "";
  String from = "";
  String matricule = "";

  RxBool finConv = false.obs;

  Widget? chatt;

  @override
  void initState() {
    //192.168.1.68
    //10.0.2.2:8080
    //epstapp.herokuapp.com
    //pepiteapp.herokuapp.com
    var encoded = utf8.encode(widget.nom!);
    var decoded = utf8.decode(encoded);

    _channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://${Connexion.ws}/chat/$decoded/client'), //${widget.nom}192.168.43.2
    );
    //
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
        contenu = map["content_"] ?? "";
        hostId = map["hostId_"] ?? "";
        clientId = map["clientId_"] ?? "";
        from = map["from_"] ?? "";
        matricule = map["matricule_"] ?? "";
        //String from = map["from"] ?? "";
        //
        if (map["conversation_"] != true) {
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
          for (var element in listeConv) {
            bool v = listeConv.remove(element);
            v ? print("Effectué") : print("Pas éffectué");
          }
          chatt = Container();
        } else if (map["conversation_"] == "Fin de la conversation") {
          //
          finConv.value = true;
        } else {
          listeConSave.add("$contenu\n");
          contenu != "" ? listeConv.add(smsMessage(false, contenu)) : print("");
          //listeConv.add(smsMessage(false, contenu));
          // chatt = ChattConv(
          //   "idSessionHote",
          //   listeConv,
          //   hostId,
          //   clientId,
          //   from,
          //   matricule,
          //   user: "${widget.nom}",
          // );
        }
      });
    }, onDone: () {
      //
    }, onError: (e) {
      Get.back();
      Get.snackbar("Connexion",
          "Un problème de connexion avec le serveur est survenu. $e");
    });

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
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                DateTime dateTime = DateTime.now();
                String date = "";
                String heure = "";
                //
                date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                heure = "${dateTime.hour}:${dateTime.minute}";
                //
                _channel!.sink.add(
                    """{"from_":"${widget.nom}","to_":"","content_":"","hostId_":"$hostId","clientId_":"$clientId","close_":true,"all_":false,"visible_":"non","conversation_": false,"matricule_":"$matricule","date_":"$date","heure_":"$heure"}""");

                Get.back();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Agent DGC/EPST"),
              ],
            ),
          ),
          body: Obx(() {
            if (listeConv.isEmpty) {
              return Center(
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
                        child: const LinearProgressIndicator(),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Etablissement de la communication avec un agent de la DGC",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              //
              TextEditingController chatCont = TextEditingController();
              //
              DateTime dateTime = DateTime.now();
              String date = "";
              String heure = "";
              //
              date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
              heure = "${dateTime.hour}:${dateTime.minute}";
              //
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: List.generate(
                        listeConv.length,
                        (index) {
                          return listeConv[index];
                        },
                      ),
                    ),
                  ),
                  Obx(() {
                    if (finConv.value) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: const Text("Fin de la conversation"),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: SafeArea(
                          child: Row(
                            children: [
                              const SizedBox(
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          print(
                                              """{"from_":"${widget.nom}","to_":"","content_":"${chatCont.text}","hostId_":"$hostId","clientId_":"$clientId","close_":false,"all_":false,"visible_":"non","conversation_": true}""");
                                          //
                                          setState(() {
                                            listeConv!.add(smsMessage(
                                                true, chatCont.text));
                                            _channel!.sink.add(
                                                """{"from_":"${widget.nom}","to_":"","content_":"${chatCont.text}","hostId_":"$hostId","clientId_":"$clientId","close_":true,"all_":false,"visible_":"non","conversation_": true,"matricule_":"$matricule","date_":"$date","heure_":"$heure"}""");
                                            chatCont.clear();
                                            listeConv.clear();
                                            Get.back();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.blue.shade400,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller: chatCont,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          print(
                                              """{"from_":"${widget.nom}","to_":"","content_":"${chatCont.text}","hostId_":"$hostId","clientId_":"$clientId","close_":false,"all_":false,"visible_":"non","conversation_": true}""");
                                          //
                                          setState(() {
                                            listeConv.add(smsMessage(
                                                true, chatCont.text));
                                            _channel!.sink.add(
                                                """{"from_":"${widget.nom}","to_":"","content_":"${chatCont.text}","hostId_":"$hostId","clientId_":"$clientId","close_":false,"all_":false,"visible_":"non","conversation_": true,"matricule_":"$matricule","date_":"$date","heure_":"$heure"}""");
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
                      );
                    }
                  }),
                ],
              );
            }
          })),
      onWillPop: () {
        _channel!.sink.add(
            """{"from_":"","to_":"","content_":"","hostId_":"","clientId_":"","close_":true,"all_":false,"visible_":"non","conversation_": false,"matricule_":"","date_":"","heure_":""}""");
        //
        _channel!.closeCode;
        //
        listeConv.clear();
        Get.back();
        //
        Navigator.of(context).pop();
        return Future.value(true);
      },
    );
  }

  Widget smsMessage(bool t, String contenu) {
    //
    var encoded = utf8.encode(contenu);
    var decoded = utf8.decode(encoded);
    //
    if (t) {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            decoded,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: const Color(0xffE7E7ED),
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            decoded,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}
