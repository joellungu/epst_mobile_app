import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClinOeil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClinOeil();
  }
}

class _ClinOeil extends State<ClinOeil> {
  //
  String? videoId;
  //print(videoId); // BBAyRBTfsOU
  //
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'hZkrlgi__Rw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),);

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=hZkrlgi__Rw");
    //
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),);
    //

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child:YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          //videoProgressIndicatorColor: Colors.amber,
        ),
      ),
    );
  }
}
