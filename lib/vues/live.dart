import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveStream extends StatefulWidget {
  String? titre;

  LiveStream({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _LiveStream();
  }
}

class _LiveStream extends State<LiveStream> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'jVYG_eH5UMU',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre!),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
