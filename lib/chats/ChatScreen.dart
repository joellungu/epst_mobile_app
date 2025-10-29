import 'dart:async';

import 'package:epst_app/chats/ApiService.dart';
import 'package:epst_app/chats/Conversation.dart';
import 'package:epst_app/chats/Message.dart';
import 'package:epst_app/chats/MessageBubble.dart';
import 'package:epst_app/chats/SendMessageRequest.dart' hide MessageType;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatScreen({Key? key, required this.conversation}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  final ApiService _apiService = ApiService();
  //
  Timer? tt;
  //
  RxBool converser = true.obs;

  @override
  void initState() {
    super.initState();
    tt = Timer.periodic(const Duration(seconds: 2), (t) async {
      _loadMessages();
    });
    // Démarrer WebSocket pour les nouveaux messages
  }

  void _loadMessages() async {
    try {
      List<Message> messages = await _apiService.getMessages(
        widget.conversation.id!,
      );
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('Erreur chargement messages: $e');
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("Message d'erreur: $e")));
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = _messageController.text;
    _messageController.clear();

    try {
      await _apiService.sendMessage(
        SendMessageRequest(
          conversationId: widget.conversation.id!,
          sender: widget.conversation.clientId,
          content: message,
        ),
      );
    } catch (e) {
      print('Erreur envoi message: $e');
    }
  }

  void _fermerMessage() async {
    //final message = _messageController.text;
    _messageController.clear();

    try {
      await _apiService.fermerMessage(
        SendMessageRequest(
          conversationId: widget.conversation.id!,
          sender: widget.conversation.clientId,
          content: "Fin de la conversation",
        ),
      );
    } catch (e) {
      print('Erreur envoi message: $e');
    }
  }

  @override
  void dispose() {
    //
    tt!.cancel();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Retourne false pour empêcher la navigation retour
        //
        // if (t) return; // si la navigation a déjà eu lieu, on ne fait rien

        final shouldExit = await showExitChatDialog(context);
        if (shouldExit == true && context.mounted) {
          _fermerMessage();
          Timer(const Duration(milliseconds: 100), () {
            //
            Navigator.of(context).pop();
          });
          // quitte réellement la page
          return true;
        } else {
          //
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Conversation avec un agent du Ministère',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message.sender == widget.conversation.clientId;
                  // ignore: unrelated_type_equality_checks
                  // converser.value = message.type == MessageType.TEXT;
                  //
                  Timer(const Duration(milliseconds: 100), () {
                    converser.value =
                        message.type.name == MessageType.TEXT.name;
                  });

                  return MessageBubble(message: message, isMe: isMe);
                },
              ),
            ),
            Obx(
              () => Container(
                height: 65,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                child: converser.value
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red.shade700),
                            onPressed: () async {
                              //
                              bool? shouldExit =
                                  await showExitChatDialog(context);
                              print("Retour: $shouldExit");

                              if (shouldExit!) {
                                // Fermer le chat
                                _fermerMessage();
                                Timer(const Duration(milliseconds: 100), () {
                                  //
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Tapez votre message...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: _sendMessage,
                          ),
                        ],
                      )
                    : Text("La conversation a été fermé."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> showExitChatDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // empêche de fermer en cliquant dehors
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Animation Lottie (optionnel) — remplace ou supprime si tu ne veux pas de dépendance
              // Lottie.asset('assets/animations/exit.json', height: 120, repeat: false),

              const SizedBox(height: 6),
              const Icon(Icons.exit_to_app_rounded,
                  size: 88, color: Colors.redAccent),

              const SizedBox(height: 12),
              const Text(
                "Veux-tu quitter la conversation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                "En quittant, votre conversation sera automatiquement archivé",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[800]),
              ),

              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child:
                              Text("Rester", style: TextStyle(fontSize: 16))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 3,
                      ),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child:
                              Text("Quitter", style: TextStyle(fontSize: 16))),
                    ),
                  ),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
