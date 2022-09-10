
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatTest();
  }

}

class _ChatTest extends State<ChatTest> {

  late StompClient client;
  WebSocketChannel? _channel;
  //
  var socket = io(
      'http://10.0.2.2:8080/', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });

  @override
  void initState() {
    /*
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8080/websocket-server'),
    );
    //
    _channel!.stream.listen((message){
      print(message);
    });
    //
    print(_channel);
    */
    /*
    socket.on('connect', (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on("connecting", (data) => print('connecting'));
    socket.on('connect_error', (data) {
      print(data);
      socket.emit('msg', 'test');
    });
    */

    /*
    client = StompClient(
        config: StompConfig.SockJS(
            url: 'http://10.0.2.2:8080',
            onConnect: (e){
              print("Cool connecté $e");
            },
            onStompError: (e){
                print(e);
            },
            onWebSocketDone: (){
                print("connecté et tout");
            }
        )
    );
    client.activate();
    */
    //
    client = StompClient(
        config: StompConfig(
            url: 'ws://10.0.2.2:8080/websocket-server',
            onConnect: (e){
              print("Cool connecté $e");
            },
            onWebSocketError: (dynamic error) => print(error.toString()),
            onStompError: (e){
              print(e);
            },
            onWebSocketDone: (){
              print("connecté et tout");
            }
        )
    );
    client.activate();
    //

    super.initState();
  }

  @override
  void dispose() {
    //
    client.deactivate();
    //
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          client.subscribe(destination: "/topic/messages", callback: (e){
            print("Even: $e");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
