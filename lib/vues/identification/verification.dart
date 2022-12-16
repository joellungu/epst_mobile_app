import 'package:epst_app/vues/identification/identification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'identification_controller.dart';

class Verification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Verification();
  }
}

class _Verification extends State<Verification> {
  //
  int p = 0;
  int d = 0;
  //
  List listeProvince = [
    "Bas-Uele",
    "Équateur",
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
  //
  int option = 0;
  bool obscuretext = true;
  //

  int ti = 0;
  int a = 1900;
  //
  RxBool demande = true.obs;
  //
  TextEditingController matricule = TextEditingController();
  TextEditingController mot_de_passe = TextEditingController();

  //
  List liste_annee = [];
  //
  @override
  void initState() {
    //
    for (int i = 0; i < 500; i++) {
      liste_annee.add(a);
      a++;
    }
    //lien_siite
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vérification"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            //
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/LOGO-MINEPST-BON.png",
                height: 200,
                width: 200,
                //color: Colors.white,
                //colorBlendMode: BlendMode.color,
              ),
              const SizedBox(
                height: 70,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Matricule",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: matricule,
                decoration: InputDecoration(
                  //prefixIcon: Text("De:"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text("Matricule"),
                  //prefixText: "De: "
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mot de passe",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: mot_de_passe,
                obscureText: obscuretext,
                decoration: InputDecoration(
                    //prefixIcon: Text("De:"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    label: const Text("Mot de passe"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscuretext = obscuretext ? false : true;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    )),
              ),
              const SizedBox(
                height: 50,
              ),

              ///
              ElevatedButton(
                onPressed: () async {
                  //
                  String mat = matricule.text;
                  String mdp = mot_de_passe.text;

                  matricule.clear();
                  mot_de_passe.clear();
                  IdentificationController identificationController =
                      Get.find();
                  identificationController.login(mat, mdp);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: const Text("Vérifier"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
