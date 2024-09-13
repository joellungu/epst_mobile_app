import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/demande_transfere/transfere_controller.dart';
import 'package:epst_app/vues/ige/recherche_ecole.dart';
import 'package:epst_app/widgets/paiement.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DemandeTransfere extends StatefulWidget {
  const DemandeTransfere({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemandeTransfere();
  }
}

class _DemandeTransfere extends State<DemandeTransfere> {
  WebViewController? controlleur;

  TextEditingController nom = TextEditingController();
  TextEditingController postnom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController nom_pere = TextEditingController();
  TextEditingController nom_mere = TextEditingController();
  TextEditingController filiere_avant = TextEditingController();
  TextEditingController filiere_apres = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController lieu_de_naissance = TextEditingController();
  List genres = ["Homme", "Femme"];
  int genre = 0;
  int option1 = 0;
  int option2 = 0;
  int dd1 = 0;
  int dd2 = 0;
  //
  List listeOptions = [
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
  int p = 9;
  //
  int p_e_1 = 0;
  int p_e_2 = 0;
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
  List<String> listeDistrict_1 = [];
  List<String> listeDistrict_2 = [];
  //
  //
  String ext1 = "png";
  RxInt i = 0.obs;
  XFile? img1;
  //
  DateTime? d;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande de transfère"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text("Informations personnel"),
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
                label: const Text("Nom père"),
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
                label: const Text("Nom mère"),
                //prefixText: "De: "
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: telephone,
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
            //
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
                      "  Option avant:",
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<int>(
                          value: option1,
                          /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                          isExpanded: true,
                          onChanged: (value) {
                            option1 = value as int;
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
                    const Text(
                      "  Option après",
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<int>(
                          value: option2,
                          /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                          isExpanded: true,
                          onChanged: (value) {
                            option2 = value as int;
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
                            p = value as int;
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
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Information lié à l'ecole de provenance",
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
                  showSearch(context: context, delegate: RechercheEcole());
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
                              "${ecole1.value["ecole"] ?? ''} / ${ecole1.value["province"] ?? ''}",
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
                          value: p_e_1,
                          onChanged: (value) {
                            p_e_1 = value as int;
                            listeDistrict_1.clear();
                            setState(() {
                              for (var element in listeDistrict2) {
                                if ("${element['p']}".toLowerCase() ==
                                    ("${listeProvince[p_e_1]}".toLowerCase())) {
                                  print("$element");
                                  listeDistrict_1.add("${element['d']}");
                                }
                              }
                            });
                            print(listeDistrict_1);
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
                          value: dd1,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            dd1 = value as int;
                            setState(() {});
                            //value = s;
                          },
                          items: List.generate(
                            listeDistrict_1.length,
                            (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(listeDistrict_1[index]),
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
              height: 15,
            ),
            //////////////////////
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Information lié à l'ecole de destination",
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
                  showSearch(context: context, delegate: RechercheEcole2());
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
                              "${ecole2.value["ecole"] ?? ''} / ${ecole2.value["province"] ?? ''}",
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
                          value: p_e_2,
                          onChanged: (value) {
                            p_e_2 = value as int;
                            listeDistrict_2.clear();
                            setState(() {
                              for (var element in listeDistrict2) {
                                if ("${element['p']}".toLowerCase() ==
                                    ("${listeProvince[p_e_2]}".toLowerCase())) {
                                  print("$element");
                                  listeDistrict_2.add("${element['d']}");
                                }
                              }
                            });
                            print(listeDistrict_2);
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
                          value: dd2,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            dd2 = value as int;
                            setState(() {});
                            //value = s;
                          },
                          items: List.generate(
                            listeDistrict_2.length,
                            (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(listeDistrict_2[index]),
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
            ElevatedButton.icon(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                // Pick an image
                img1 = await picker.pickImage(source: ImageSource.gallery);
                ext1 = img1!.name.split(".").last;
                i = 1.obs;
                print("ext ${img1!.name}".split(".").last);
                // Capture a photo
                Timer(const Duration(seconds: 1), () {
                  setState(() {
                    //
                  });
                });
              },
              icon: const Icon(Icons.file_present),
              label: const Text("Joindre dernière bultin"),
            ),
            Obx(() => i.value != 0
                ? Container(
                    height: Get.size.height / 4,
                    width: Get.size.width / 1.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(img1!.path)))),
                    //child: Image.file(File(img!.path)),
                  )
                : Container()),
            ElevatedButton(
              onPressed: () async {
                if (nom.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ nom");
                } else if (postnom.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ postnom");
                } else if (prenom.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ prenom");
                } else if (nom_pere.text.isEmpty) {
                  messageErreur(
                      "Erreur", "Veuillez remplire le champ matricule");
                } else if (nom_mere.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ notes");
                } else if (adresse.text.isEmpty) {
                  messageErreur(
                      "Erreur", "Veuillez associer la photo de la carte");
                } else if (telephone.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ postnom");
                } else if (prenom.text.isEmpty) {
                  messageErreur("Erreur", "Veuillez remplire le champ prenom");
                } else if (lieu_de_naissance.text.isEmpty) {
                  messageErreur(
                      //
                      "Erreur",
                      "Veuillez remplire le champ matricule");
                } else if (img1 == null) {
                  messageErreur(
                      //img1
                      "Erreur",
                      "Photo du bultin");
                } else {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  //
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    //
                    Get.dialog(Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const CircularProgressIndicator(
                          strokeWidth: 7,
                        ),
                      ),
                    ));
                    //
                    //Future<Uint8List> i = img1!.readAsBytes();
                    //File file = File(img1!.path);
                    //
                    Uint8List l1 = await img1!.readAsBytes();
                    //
                    DateTime dd = DateTime.now();
                    String vd = d!.day < 9 ? "0${d!.day}" : "${d!.day}";
                    String vm = d!.month < 9 ? "0${d!.month}" : "${d!.month}";
                    String ddd = "${d!.year}-$vm-$vd";
                    //
                    Map<String, dynamic> formulaireD = {
                      //"id": getCode(),
                      "nom": nom.text,
                      "postnom": postnom.text,
                      "prenom": prenom.text,
                      "sexe": genres[genre],
                      "lieuNaissance": lieu_de_naissance.text,
                      "dateNaissance": ddd,
                      "telephone": telephone.text,
                      "nompere": nom_pere.text,
                      "nommere": nom_mere.text,
                      "adresse": adresse.text,
                      "option_avant": listeOptions[option1],
                      "option_apres": listeOptions[option2],
                      "provinceOrigine": listeProvince[p],
                      "ecoleProvenance": ecole1.value["ecole"],
                      "ecoleProvenanceProv": ecole1.value["province"],
                      "ecoleProvenanceDistric": listeDistrict_1[dd1],
                      "ecoleDestination": ecole2.value["ecole"],
                      "ecoleDestinationProv": ecole2.value["province"],
                      "ecoleDestinationDistric": listeDistrict_2[dd2],
                      "photo": l1,
                      "ext1": ext1,
                      "datedemande": "${dd.day}/${dd.month}/${dd.year}",
                      "valider": 0,
                    };
                    //
                    //send(formulaireD);
                    showDialog(
                      context: context,
                      builder: (c) {
                        return Material(
                          color: Colors.transparent,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 250,
                              width: 270,
                              child: PayementMethode(
                                  formulaireD, 2, send, "palmares", "palmares"),
                            ),
                          ),
                        );
                      },
                    );
                    //____________________________________________________________
                  } else {}
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: const Text("Demander"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Ce formulaire est payant (2 dollar)",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  send(Map formulaireD) async {
    TransfereController transfereController = Get.find();
    //ByteArrayInputStream//formulaireD
    //
    Timer(const Duration(seconds: 1), () {
      transfereController.faireUneInscription(formulaireD);
    });
  }

  //
  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
  }

  //
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
}
