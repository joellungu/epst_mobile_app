import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DirectEductivi extends StatefulWidget {
  const DirectEductivi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DirectEductivi();
  }
}

class _DirectEductivi extends State<DirectEductivi> {
  //
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'l8PMl7tUDIE',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct"),
      ),
      backgroundColor: Colors.black,
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // some widgets
              player,
              //some other widgets
            ],
          );
        },
      ),
    );
  }
}
