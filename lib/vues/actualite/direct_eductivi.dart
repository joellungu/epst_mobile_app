import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DirectEductivi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DirectEductivi();
  }
}

class _DirectEductivi extends State<DirectEductivi> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "http://eu.oraostream.com:8081/KIN-EDUCTV/ledirect/playlist.m3u8",
    "http://eu.oraostream.com:8081/eductv-orao/playlist.m3u8",
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    _videoPlayerController2 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hello',
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
            TextSpan(
              text: ' from ',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            TextSpan(
              text: 'subtitles',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )
          ],
        ),
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: 'Whats up? :)',
        // text: const TextSpan(
        //   text: 'Whats up? :)',
        //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
        // ),
      ),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 1),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct"),
      ),
      backgroundColor: Colors.black,
      body: HtmlWidget(
        // the first parameter (`html`) is required
        '''<video width="${Get.size.width}" height="${Get.size.height}" controls autoplay>
            <source src="http://eu.oraostream.com:8081/eductv-orao/playlist.m3u8" type="video/mp4"></video>''',

        // all other parameters are optional, a few notable params:

        // specify custom styling for an element
        // see supported inline styling below
        customStylesBuilder: (element) {
          if (element.classes.contains('foo')) {
            return {'color': 'red'};
          }

          return null;
        },

        // render a custom widget
        customWidgetBuilder: (element) {
          if (element.attributes['foo'] == 'bar') {
            //return FooBarWidget();
          }

          return null;
        },

        // turn on selectable if required (it's disabled by default)
        isSelectable: true,

        // these callbacks are called when a complicated element is loading
        // or failed to render allowing the app to render progress indicator
        // and fallback widget
        onErrorBuilder: (context, element, error) =>
            Text('$element error: $error'),
        onLoadingBuilder: (context, element, loadingProgress) => Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        ),

        // this callback will be triggered when user taps a link
        //onTapUrl: (url) => print('tapped $url'),
        // select the render mode for HTML body
        // by default, a simple `Column` is rendered
        // consider using `ListView` or `SliverList` for better performance
        renderMode: RenderMode.column,
        // set the default styling for text
        textStyle: TextStyle(fontSize: 14),
        // turn on `webView` if you need IFRAME support (it's disabled by default)
        webView: true,
      ),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
