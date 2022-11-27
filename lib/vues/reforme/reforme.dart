import 'dart:async';
import 'dart:io';
import 'package:epst_app/vues/reforme/reforme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Reforme extends GetView<ReformeController> {
  //
  Reforme({this.titre}) {
    controller.getListeMag(2);
  }
  //
  String? titre;
  var box = GetStorage();
  //
  RxString text = "".obs;

  RxBool loads = true.obs;
  //
  //List liste = [];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$titre"),
        actions: [
          /*IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          )*/
        ],
      ),
      body: controller.obx(
        (List<dynamic>? stat) {
          if (stat != null) {
            print(stat);
            RxList l = RxList(stat);
            print(l);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  height: 45,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onChanged: (t) {
                      //
                      text.value = t;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => ListView(
                      children: List.generate(l.length, (index) {
                        //
                        RxInt load = 0.obs;
                        Timer(const Duration(milliseconds: 1), () async {
                          //
                          final Directory directory =
                              await getApplicationDocumentsDirectory();
                          String path = directory.path;
                          load.value = await File(
                                      '$path/${l[index]['id']}.${l[index]['extention']}')
                                  .exists()
                              ? 1
                              : 0;
                          //_spawnAndReceive("${state[index]['id']}",
                          //state[index]['extention'], directory.path);
                        });
                        //Timer(const Duration(milliseconds: 500), () async {
                        //});
                        print("${l[index]["libelle"]}"
                            .toLowerCase()
                            .contains(text.value.toLowerCase()));
                        //
                        return "${l[index]["libelle"]}"
                                .toLowerCase()
                                .contains(text.value.toLowerCase())
                            ? Obx(
                                () => ListTile(
                                  onTap: () async {
                                    if (load.value == 1) {
                                      final Directory directory =
                                          await getApplicationDocumentsDirectory();
                                      print(
                                          "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
                                      OpenResult or = await OpenFile.open(
                                          "${directory.path}/${l[index]["id"]}.${l[index]["extention"]}");
                                      print(or.message);
                                      print(or.type);
                                    } else {
                                      load.value = 2;
                                      //
                                      load.value = await controller.write(
                                          "${l[index]["id"]}",
                                          "${l[index]["extention"]}");
                                      print("lecture");
                                    }
                                  },
                                  leading: Image.asset(
                                    "assets/logo-app.jpeg",
                                    color: Colors.blue,
                                    colorBlendMode: BlendMode.color,
                                  ),
                                  title: Text(l[index]["libelle"]),
                                  subtitle: Text(l[index]["date"]),
                                  trailing: load.value == 1
                                      ? const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                        )
                                      : load.value == 0
                                          ? const Icon(
                                              Icons.download,
                                              color: Colors.black,
                                            )
                                          : Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                ),
                              )
                            : Container();
                      }),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container(
              child: Text(""),
            );
          }
        },
        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade400,
          child: ListView(
            children: List.generate(
              10,
              (index) => ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                title: Container(
                  height: 10,
                  width: 200,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        onEmpty: const Center(
          child: Text(
            'Vide',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => Text("$error"),
      ),
    );
  }
}

/*
onTap: () async {
                                          if (load.value == 1) {
                                            final Directory directory =
                                            await getApplicationDocumentsDirectory();
                                            print(
                                                "${directory
                                                    .path}/${l[index]["id"]}.${l[index]["extention"]}");
                                            OpenResult or = await OpenFile.open(
                                                "${directory
                                                    .path}/${l[index]["id"]}.${l[index]["extention"]}");
                                            print(or.message);
                                            print(or.type);
                                          } else {
                                            load.value = 2;
                                            //
                                            load.value = await controller.write(
                                                "${l[index]["id"]}",
                                                "${l[index]["extention"]}");
                                            print("lecture");
                                          }
                                        },

 */

class Lire extends StatefulWidget {
  String? titre;

  Lire({this.titre});

  @override
  State<StatefulWidget> createState() {
    return _Lire();
  }
}

class _Lire extends State<Lire> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '74EdyJzluWY',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
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


//https://www.eduquepsp.education/
/*
ListView(
        padding: EdgeInsets.only(
          top: 20,
        ),
        children: List.generate(100, (index) {
          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PdfVue(
              //       titre: "DYG  duy UYd  DUQY uysd",
              //     ),
              //   ),
              // );
            },
            child: Card(
              elevation: 0,
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.photo_album,
                          size: MediaQuery.of(context).size.width / 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                """Nostrud officia ut irure commodo excepteur. Velit occaecat dolore sunt cupidatat exercitation. Aliquip incididunt amet exercitation anim commodo tempor enim ullamco aliquip. Nulla cillum occaecat cillum duis ipsum fugiat occaecat pariatur esse irure adipisicing. Elit duis id fugiat aliqua est. Irure occaecat qui ipsum amet amet est sint magna nisi quis duis id occaecat cupidatat. Laborum sunt consectetur in fugiat nisi.""",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "12/12/2022",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
*/