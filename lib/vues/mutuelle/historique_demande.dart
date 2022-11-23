import 'package:epst_app/vues/mutuelle/mutuelle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoriqueDemande extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoriqueDemande();
  }

}

class _HistoriqueDemande extends State<HistoriqueDemande> {

  //
  MutuelleController mutuelleController = MutuelleController();
  var box = GetStorage();
  RxList l = RxList();
  //
  @override
  void initState() {
    //
    //mutuelleController.
    //
    super.initState();
    //
    l.value = box.read("historique") ?? [];
    print(box.read("historique"));
    //
  }
  //
  Future<int> getStatus(String id) async {
    return mutuelleController.getStatus(id) ;
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation"),
      ),
      body: Obx(()=> ListView(
        children: List.generate(l.length, (index) {
          Map e = l[index];
          return ListTile(
            leading: Icon(Icons.file_present_rounded),
            title: Text("${e['services']}"),
            //${e['nom']} ${e['postnom']} ${e['prenom']}
            subtitle: Text("${e['matricule']} ${e['direction']} / ${e['jour'] ?? ''}"),
            trailing: FutureBuilder(
              future: getStatus("${e['matricule']}"),
              builder: (context, t){
                if(t.hasData){
                  int v = t.data as int;
                  return v == 1 ? Text("Validé") : v == 2 ? Text("Refusé") : Text("En attente");
                }else if(t.hasError){
                  return Text("...");
                }

                return Container(height: 50,width: 50,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),);
              },
            ),
          );
        }),
      ))
    );
  }

}