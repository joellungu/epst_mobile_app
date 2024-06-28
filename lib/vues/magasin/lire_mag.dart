import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'magasin_controller.dart';

class LireMag extends StatefulWidget {
  Map<String, dynamic> mag;
  LireMag(this.mag, {Key? key}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _LireMag();
  }
}

class _LireMag extends State<LireMag> {
  //
  RxInt load = 0.obs;
  //
  MagasinController magasinController = Get.find();
  //
  @override
  void initState() {
    //
    loader();
    //
    super.initState();
  }

  //
  loader() async {
    //
    final Directory directory = await getApplicationDocumentsDirectory();
    //
    print(
        ':::${directory.path}/${widget.mag["id"]}.${widget.mag["extention"]}');
    //
    bool vc = await File(
            '${directory.path}/${widget.mag["id"]}.${widget.mag["extention"]}')
        .exists();
    //bool v = await Directory(
    //      '${directory.path}/${state[index]["id"]}.${state[index]["extention"]}')
    //.exists();
    //
    if (vc) {
      load.value = 1;
      print("Salut: 1");
    } else {
      //load.value = 2;
      print("Salut: 2");
      load.value = await magasinController.write(
          "${widget.mag["id"]}", "${widget.mag["extention"]}");
    }
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => load.value == 0
            ? Center(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                ),
              )
            : ListTile(
                onTap: () async {
                  final Directory directory =
                      await getApplicationDocumentsDirectory();
                  //
                  //final File file = File('${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}');
                  //
                  print(
                      "${directory.path}/${widget.mag["id"]}.${widget.mag["extention"]}");
                  //
                  //File f = await File("${directory.path}/${liste[index]["id"]}.${liste[index]["extention"]}")
                  //  .writeAsBytes(box.read("${liste[index]["id"]}"));
                  //print(box.read("${liste[index]["id"]}"));

                  final or = await OpenFilex.open(
                      "${directory.path}/${widget.mag["id"]}.${widget.mag["extention"]}");
                  print(or.message);
                  print(or.type);
                },
                leading: const Icon(
                  Icons.file_copy_rounded,
                  color: Colors.black,
                ),
                title: Text(widget.mag["libelle"]),
                subtitle: Text(widget.mag["date"]),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
      ),
    );
  }
}
