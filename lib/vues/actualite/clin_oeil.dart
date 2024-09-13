import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClinOeil extends StatefulWidget {
  const ClinOeil({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ClinOeil();
  }
}

class _ClinOeil extends State<ClinOeil> {
  //
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
  //
  @override
  void initState() {
    //
    //_controller.
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = Get.size.width;
    var h = Get.size.height;

    return Scaffold(
      appBar: AppBar(),
      // body: YoutubePlayer(
      //   controller: _controller,
      //   showVideoProgressIndicator: true,
      //   progressIndicatorColor: Colors.amber,
      //   progressColors: const ProgressBarColors(
      //     playedColor: Colors.amber,
      //     handleColor: Colors.amberAccent,
      //   ),
      //   onReady: () {
      //     // _controller.addListener(listener);
      //   },
      // ),
    );
  }
}
