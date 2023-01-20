import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ClinOeil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClinOeil();
  }
}

class _ClinOeil extends State<ClinOeil> {
  //

  //
  @override
  void initState() {
    //

    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = Get.size.width;
    var h = Get.size.height;

    return Scaffold(
      appBar: AppBar(),
      body: HtmlWidget(
        '''
          <iframe id="player" type="text/html" width="$w" height="$h"
            src="https://www.youtube.com/channel/UCpAqEBwacNuVcIXSgG0qA6g"
            frameborder="0">
          </iframe>
          ''',
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
        isSelectable: true,
        //onTapUrl: (url) => print('tapped $url'),
        webView: true,
      ),
    );
  }
}
