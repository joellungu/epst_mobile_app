import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DirectEductivi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DirectEductivi();
  }
}

class _DirectEductivi extends State<DirectEductivi> {
  var controller = YoutubePlayerController(initialVideoId: "u9foWyMSATM");
  @override
  void initState() {
    //
    super.initState();
  }

  @override
  void dispose() {
    //
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live"),
      ),
      body: YoutubePlayer(controller: controller),
    );
  }
}
