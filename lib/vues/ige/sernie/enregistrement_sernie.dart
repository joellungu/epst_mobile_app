import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/main.dart';
import 'package:epst_app/models/historiquedb.dart';
import 'package:epst_app/utils/depotcontroler.dart';
import 'package:epst_app/vues/ige/recherche_annee.dart';
import 'package:epst_app/vues/ige/recherche_ecole.dart';
import 'package:epst_app/vues/ige/recherche_antenne.dart';
import 'package:epst_app/vues/ige/recherche_ecole_sernie.dart';
import 'package:epst_app/vues/ige/sernie/sernie_controller.dart';
//import 'package:epst_app/vues/transsfere.dart';
import 'package:epst_app/widgets/paiement.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
//import 'mutuelle_controller.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class EnregistrementSernie extends StatefulWidget {
  String? titre;

  EnregistrementSernie({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EnregistrementSernie();
  }
}

class _EnregistrementSernie extends State<EnregistrementSernie> {
  TextEditingController Territoire = TextEditingController();
  TextEditingController Secteur = TextEditingController();
  TextEditingController Groupement = TextEditingController();
  TextEditingController Village = TextEditingController();
  TextEditingController Nationalite = TextEditingController();
  TextEditingController adressePhysiqueEcole = TextEditingController();
  TextEditingController acoleNom = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController postnom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController nom_pere = TextEditingController();
  TextEditingController nom_mere = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController lieu_de_naissance = TextEditingController();
  List genres = ["Homme", "Femme"];
  int genre = 0;
  //
  var controller = ScrollController();
  //
  List reseaux = [
    "ECOLES NON CONVENTIONNEES",
    "ECOLES CONVENTIONNEES CATOLIQUE",
    "ECOLES CONVENTIONNEES FRATERNITE",
    "ECOLES CONVENTIONNEES ISLAMIQUE",
    "ECOLES CONVENTIONNEES KIMBANGUISTE",
    "ECOLES CONVENTIONNEES PROTESTANTE",
    "ECOLES PRIEES AGREEES",
    "ECOLES CONVENTIONNEES SALUTISTE",
    "ECOLES CONVENTIONNEES DE L’EGLISE DU REVEIL AU CONGO",
    "ECOLES CONVENTIONNEES ADVENTISTE",
    "ECOLES CONVENTIONNEES DE L’EGLISE DU BON NOUVEAU MESSAGER",
    "ECOLES CONVENTIONNEES DE L’EGLISE LIBRE DU CONGO",
  ];
  int rs = 0;
  //
  List niveaux = [
    "Maternelle",
    "Primaire",
    "Secondaire",
  ];
  int nv = 0;
  //
  List types = [
    "Examens d'Etat",
    "TENASOSP",
    "ENAFEP",
    "Identification SERNIE",
    "JURY NATIONAL C.C"
  ];
  //
  List listeOptions = [
    "MATERNELLE,101",
    "PRIMAIRE,101",
    "EDUCATION DE BASE,101",
    "LATIN-PHILOSOPHIE,101",
    "MATHEMATIQUE-PHYSIQUE,102",
    "CHIMIE-BIOLOGIE,103",
    "LATIN-GREC,104",
    "LATIN-MATHEMATIQUE,105",
    "SCIENCES,106",
    "PEDAGOGIE GENERALE,201",
    "EDUCATION PHYSIQUE,202",
    "NORMALE,203",
    "PEDAGOGIE MATERNELLE,204",
    "COMMERCIALE ET GESTION,301",
    "SECRETARIAT-ADMINISTRATION,302",
    "SOCIALE,401",
    "ARTS PLASTIQUES,501",
    "ARTS DRAMATIQUES,502",
    "MUSIQUE,503",
    "ESTHETIQUE & COIFFURE,504",
    "COIFFURE,505",
    "COUPE-COUTURE,601",
    "HOTESSE D'ACCUEIL,701",
    "HOTELLERIE & RESTAURATION,702",
    "TOURISME,704",
    "AGRICULTURE GENERALE,801",
    "PECHE ET NAVIGATION,802",
    "VETERINAIRE,803",
    "INDUSTRIES AGRICOLES,804",
    "NUTRITION,805",
    "FORESTERIE,806",
    "MECANIQUE GENERALE,901",
    "MECANIQUE MACHINES-OUTILS,902",
    "ELECTRICITE,903",
    "CONSTRUCTION,904",
    "CHIMIE INDUSTRIELLE,905",
    "ELECTRONIQUE,906",
    "IMPRIMERIE,907",
    "COMMUTATION,908",
    "RADIO-TRANSMISSION,909",
    "METEOROLOGIE,910",
    "AVIATION CIVILE,911",
    "PETRO-CHIMIE,914",
    "MECANIQUE AUTOMOBILE,915",
    "CONSTRUCTION METALLIQUE,916",
    "MENUISERIE EBENISTERIE,917",
    "MINE ET GEOLOGIE,918",
    "METALLURGIE,919",
    "DESSIN DE BATIMENT,920",
    "INSTALLATION SANITAIRE,921",
    "TOLERIE,922",
    "AJUSTAGE ET SOUDURE,923",
  ];
  //
  //
  int a = 0;
  int s = 0;
  int b = 0;
  int p = 0;
  int dd = 0;
  //
  int option = 0;
  int p_e = 0;
  int p_o = 0;
  //
  List<Map<String, dynamic>> listeDistrict2 = [
    {"p": "BAS-UELE", "d": "BAS-UELE"},
    {"p": "EQUATEUR", "d": "EQUATEUR 1"},
    {"p": "EQUATEUR", "d": "EQUATEUR 2"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 1"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 2"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 1"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 2"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 1"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 2"},
    {"p": "ITURI", "d": "ITURI 1"},
    {"p": "ITURI", "d": "ITURI 2"},
    {"p": "ITURI", "d": "ITURI 3"},
    {"p": "KASAI", "d": "KASAI 1"},
    {"p": "KASAI", "d": "KASAI 2"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 1"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 2"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 1"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 2"},
    {"p": "KINSHASA", "d": "KINSHASA-FUNA"},
    {"p": "KINSHASA", "d": "KINSHASA-LUKUNGA"},
    {"p": "KINSHASA", "d": "KINSHASA-MONT AMBA"},
    {"p": "KINSHASA", "d": "KINSHASA-PLATEAU"},
    {"p": "KINSHASA", "d": "KINSHASA-TSHANGU"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 1"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 2"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 3"},
    {"p": "KWANGO", "d": "KWANGO 1"},
    {"p": "KWANGO", "d": "KWANGO 2"},
    {"p": "KWILU", "d": "KWILU 1"},
    {"p": "KWILU", "d": "KWILU 2"},
    {"p": "KWILU", "d": "KWILU 3"},
    {"p": "LOMAMI", "d": "LOMAMI"},
    {"p": "LOMAMI", "d": "LOMAMI 2"},
    {"p": "LUALABA", "d": "LUALABA 1"},
    {"p": "LUALABA", "d": "LUALABA 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 1"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 3"},
    {"p": "MANIEMA", "d": "MANIEMA 1"},
    {"p": "MANIEMA", "d": "MANIEMA 2"},
    {"p": "MONGALA", "d": "MONGALA 1"},
    {"p": "MONGALA", "d": "MONGALA 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 1"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 3"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 1"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 2"},
    {"p": "SANKURU", "d": "SANKURU 1"},
    {"p": "SANKURU", "d": "SANKURU 2"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 2"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 1"},
    {"p": "SUD-KIVU", "d": "SUD-KIVU 3"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 1"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 2"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 1"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 2"},
    {"p": "TSHOPO", "d": "TSHOPO 1"},
    {"p": "TSHOPO", "d": "TSHOPO 2"},
    {"p": "TSHUAPA", "d": "TSHUAPA 1"},
    {"p": "TSHUAPA", "d": "TSHUAPA 2"}
  ];
  //
  List<String> listeDistrict = [];
  //
  RxInt type = 0.obs;
  List listeProvince = [
    "Bas-Uele",
    "Equateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasai",
    "Kasai central",
    "Kasai oriental",
    "Kinshasa",
    "Kongo Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];
  int pp = 9;
  //
  List classes = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int Classe = 0;
  //
  String ext1 = "png";
  RxInt i = 0.obs;
  XFile? img1;
  //
  DateTime? d;

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //

    listeDistrict.clear();
    //
    for (var element in listeDistrict2) {
      if ("${element['p']}".toLowerCase() ==
          ("${listeProvince[0]}".toLowerCase())) {
        listeDistrict.add("${element['d']}");
      }
    }
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.titre!,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        controller: controller,
        children: [
          const Text("Identité de l'élève"),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: nom,
            decoration: InputDecoration(
              //prefixIcon: Text("De:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Nom"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: postnom,
            decoration: InputDecoration(
                //prefixIcon: Text("Téléphone:"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                label: const Text("Postnom")
                //prefixText: "De: "
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: prenom,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Prenom"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "  Genre:",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: genre,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          genre = value as int;
                          print("le id: $genre");
                        },
                        items: List.generate(
                          genres.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(genres[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: lieu_de_naissance,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Lieu de naissance"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  d == null
                      ? const Text("  Date de naissance: ")
                      : Text(
                          "  Date de naissance: ${d!.day}/${d!.month}/${d!.year}"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            //
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2090),
                            ).then((value) {
                              setState(() {
                                d = value;
                              });
                            });
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("  Province d'origine:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: p,
                        onChanged: (value) {
                          p_o = value as int;
                          //listeDistrict.clear();
                          setState(() {});
                          //value = s;
                        },
                        items: List.generate(
                          listeProvince.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(listeProvince[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Territoire,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Térritoire"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Secteur,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Secteur"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Groupement,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Groupement"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Village,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Villeage"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Nationalite,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Nationalité"),
              //prefixText: "De: "
            ),
          ),

          //
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: nom_pere,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Nom du père"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: nom_mere,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Nom de la mère"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: telephone,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Numéro de téléphone"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: adresse,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Adresse"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    //showDialog(context: context, builder: builder);
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    img1 = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 75,
                      maxWidth: 500,
                      maxHeight: 500,
                    );
                    if (img1 != null) {
                      ext1 = img1!.name.split(".").last;
                      //
                      i = 1.obs;
                      print("ext ${img1!.name}".split(".").last);
                      // Capture a photo
                      Timer(const Duration(seconds: 1), () {
                        setState(() {
                          //
                        });
                      });
                    }
                  },
                  icon: const Icon(Icons.file_present),
                  label: const Text("Joindre la photo"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    //showDialog(context: context, builder: builder);
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    img1 = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 75,
                      maxWidth: 500,
                      maxHeight: 500,
                    );
                    ext1 = img1!.name.split(".").last;
                    i = 1.obs;
                    print("ext ${img1!.name}".split(".").last);
                    // Capture a photo
                    if (img1 != null) {
                      //
                      Timer(const Duration(seconds: 1), () {
                        setState(() {
                          //
                        });
                      });
                      //
                    }
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Prendre une photo"),
                ),
              ),
            ],
          ),
          Obx(() => i.value != 0
              ? Container(
                  height: Get.size.height / 4,
                  width: Get.size.width / 1.1,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: FileImage(File(img1!.path)))),
                  //child: Image.file(File(img!.path)),
                )
              : Container()),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Information lié à l'ecole",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: InkWell(
              onTap: () {
                //
                showSearch(context: context, delegate: RechercheEcoleSernie());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "  Ecole: ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        //width: Get.size.width,
                        child: Obx(
                          () => Text(
                            "${ecole_sernie.value["denomination_ecole"] ?? ''} / ${ecole_sernie.value["code_ecole"] ?? ''}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ///////////
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: adressePhysiqueEcole,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("adresse Physique Ecole"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "  Réseau:",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: rs,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          rs = value as int;
                          print("le id: $genre");
                        },
                        items: List.generate(
                          reseaux.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(reseaux[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ///////////
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "  Niveau:",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: nv,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          nv = value as int;
                          print("le id: $nv");
                        },
                        items: List.generate(
                          niveaux.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(niveaux[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "  Option:",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: option,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          option = value as int;
                          print("le id: $option");
                        },
                        items: List.generate(
                          listeOptions.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(
                                "${listeOptions[index]}".split(",")[0],
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("  Classe:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: Classe,
                        onChanged: (value) {
                          Classe = value as int;

                          //value = s;
                        },
                        items: List.generate(
                          classes.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text("${classes[index]}"),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          ///////////
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("  Province:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: p_e,
                        onChanged: (value) {
                          p_e = value as int;
                          listeDistrict.clear();
                          setState(() {
                            for (var element in listeDistrict2) {
                              if ("${element['p']}".toLowerCase() ==
                                  ("${listeProvince[p_e]}".toLowerCase())) {
                                print("$element");
                                listeDistrict.add("${element['d']}");
                              }
                            }
                          });
                          print(listeDistrict);
                          //value = s;
                        },
                        items: List.generate(
                          listeProvince.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(listeProvince[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ///////////

          ///////////
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("  Province éducationnel:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: dd,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          dd = value as int;
                          setState(() {});
                          //value = s;
                        },
                        items: List.generate(
                          listeDistrict.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(listeDistrict[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: InkWell(
              onTap: () {
                //
                showSearch(context: context, delegate: RechercheAntenne());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "  Antenne: ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        //width: Get.size.width,
                        child: Obx(
                          () => Text(
                            "${antenne.value["antenne"] ?? ''} / ${antenne.value["province"] ?? ''}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ///////////

          ///////////

          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: InkWell(
              onTap: () {
                //
                showSearch(context: context, delegate: RechercheAnnee());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  //width: Get.size.width,
                  child: Obx(
                    () => Text(
                      annee.value.isEmpty ? "Année-scolaire" : annee.value,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // const SizedBox(
          //   height: 10,
          // ),
          // Card(
          //   elevation: 0,
          //   margin: const EdgeInsets.all(0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     side: const BorderSide(color: Colors.grey),
          //   ),
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         const Text(
          //           "  Type d'identification:",
          //           style: TextStyle(fontSize: 10),
          //         ),
          //         const SizedBox(
          //           width: 20,
          //         ),
          //         Expanded(
          //           flex: 1,
          //           child: DropdownButtonHideUnderline(
          //             child: DropdownButtonFormField<int>(
          //               value: type.value,
          //               /*
          //                   style: TextStyle(
          //                       //fontSize: 12,
          //                       color: Colors.black
          //                   ),
          //                   */
          //               isExpanded: true,
          //               onChanged: (value) {
          //                 type.value = value as int;
          //                 print("le id: $type");
          //               },
          //               items: List.generate(
          //                 types.length,
          //                 (index) {
          //                   return DropdownMenuItem(
          //                     value: index,
          //                     child: Text(
          //                       types[index],
          //                       style: const TextStyle(fontSize: 13),
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),

          ///////////
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (nom.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ nom");
              } else if (postnom.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ postnom");
              } else if (lieu_de_naissance.text.isEmpty) {
                messageErreur(
                    "Erreur", "Veuillez remplire le champ lieu de naissance");
              } else if (d == null) {
                messageErreur(
                    "Erreur", "Veuillez indiquer une date de naissance");
              } else if (nom_pere.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ nom mère");
              } else if (nom_mere.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ nom mère");
              } else if (telephone.text.isEmpty) {
                messageErreur(
                    "Erreur", "Veuillez entrer un numéro de téléphone");
              } else if (adresse.text.isEmpty) {
                //
                messageErreur("Erreur", "Veuillez entrer une adresse");
              } else if (ecole.value == {}) {
                messageErreur("Erreur", "Veuillez selectionner une école");
              } else if (annee.value.isEmpty) {
                messageErreur(
                    "Erreur", "Veuillez selectionner une période (année)");
              } else if (img1 == null) {
                //
                messageErreur("Erreur", "Veuillez selectionner une photo");
              } else {
                //
                DateTime d2 = DateTime.now();
                //
                Uint8List l1 = await img1!.readAsBytes();
                //
                String vd = d!.day < 9 ? "0${d!.day}" : "${d!.day}";
                String vm = d!.month < 9 ? "0${d!.month}" : "${d!.month}";
                String ddd = "${d!.year}-$vm-$vd";
                String code = getCode();
                Map<String, dynamic> formulaireD = {
                  "code": code,
                  "nom": nom.text,
                  "postnom": postnom.text,
                  "prenom": prenom.text,
                  "sexe": genres[genre],
                  "nompere": nom_pere.text,
                  "nommere": nom_mere.text,
                  "telephone": telephone.text,
                  "adresse": adresse.text,
                  "territoire": Territoire.text,
                  "secteur": Secteur.text,
                  "groupement": Groupement.text,
                  "village": Village.text,
                  "nationalite": Nationalite.text,
                  "antenne": antenne['antenne'],
                  "code_antenne": antenne['code'],
                  "provinceOrigine": listeProvince[p_o],
                  "lieuNaissance": lieu_de_naissance.text,
                  "dateNaissance": ddd,
                  "ecole": ecole_sernie.value["denomination_ecole"],
                  "code_ecole": ecole_sernie.value["code_ecole"],
                  "adressePhysiqueEcole": adressePhysiqueEcole.text,
                  "reseaux": reseaux[rs],
                  "niveau": niveaux[nv],
                  "provinceEcole": listeProvince[p_e],
                  "provinceEducationnel": listeDistrict[dd],
                  "option": "${listeOptions[option]}".split(",")[0],
                  "annee": annee.value,
                  "classe": classes[Classe],
                  "datedemande": "${d2.day}/${d2.month}/${d2.year}",
                  "valider": 0,
                };
                //
                nom.clear();
                postnom.clear();
                prenom.clear();
                nom_pere.clear();
                nom_mere.clear();
                telephone.clear();
                adresse.clear();
                Nationalite.clear();
                //
                Village.clear();
                Secteur.clear();
                Territoire.clear();
                Groupement.clear();
                //
                ecole = {"ecole": "", "province": ""}.obs;
                antenne = {"antenne": "", "province": ""}.obs;
                Classe = 0;
                //
                d = null;
                //
                lieu_de_naissance.clear();
                telephone.clear();
                adresse.clear();
                //
                controller.jumpTo(0);
                //
                Map ph = {
                  "photo": l1,
                  "ext1": ext1,
                };
                //
                var box = GetStorage();
                List l = box.read("historique_sernie") ?? [];
                //map['photo'] = "";
                l.add(formulaireD);
                box.write("historique_sernie", l);
                box.write(code, ph);

                /*
                  */
                print("Le type vaut: ${formulaireD}");

                print("Pas payant");
                Get.snackbar("Succès", "Enregistrement éffectué");
                //
                //send2(formulaireD);
                //____________________________________________________________
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text("Enregistrer"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  //
  send2(Map formulaireD) async {
    SernieController sernieController = Get.find();
    //ByteArrayInputStream//formulaireD
    //
    Timer(const Duration(seconds: 0), () {
      sernieController.faireUneInscription(formulaireD);
    });
  }

  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
  }

  messageErreur(String titre, String message) {
    //GetSnackBar(title: titre, message: message);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titre),
          content: Text(message),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        );
      },
    );
  }

  String getReference() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<void> _createFolderAndSave(
      String folderName, List<Map<String, dynamic>> liste) async {
    try {
      //
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      //final folderName = "some_name";
      final path = Directory("$appDocPath/$folderName");
      if ((await path.exists())) {
        // TODO:
        print("exist");
      } else {
        path.create();
        for (int t = 0; t < liste.length; t++) {
          //
          File("${path.create()}/t.${liste[t]['type']}")
              .create(recursive: true)
              .then((File file) {
            //
            file.writeAsBytes(liste[t]["data"]); //
          });
        }
        //print("not exist");
      }
    } catch (e) {
      print("_______________: $e");
    }
  }

/*
  getFile2(bool v) async {
    final ImagePicker _picker = ImagePicker();
    if (v) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    } else {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    }
    // Pick an image
    //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo

    // Pick a video
    //final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    // Capture a video

    // Pick multiple images
    //final List<XFile>? images = await _picker.pickMultiImage();
  }
  */
}

/*
SizedBox(height: 20,),
              Container(height: 50,
              child: Flexible(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 25.0,
                    maxHeight: 135.0,
                  ),
                  child: new Scrollbar(
                    child: new TextField(
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //controller: tc,
                      //_handleSubmitted : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 2.0,
                            left: 13.0,
                            right: 13.0,
                            bottom: 2.0),
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                          color:Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ),
 */

