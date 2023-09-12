import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DetailsSG extends StatelessWidget {
  Map e;
  DetailsSG(this.e, {Key? key}) : super(key: key);
  //
  RxInt ie = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("""DIGE"""),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Obx(
        () => ie.value == 0
            ? ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  // const Text(
                  //   "Direction de communication et ...",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const HtmlWidget(
                    """Direction de l'Information pour la Gestion de l'Education<span style="font-family: Segoe UI Light; font-width: bold ; font-size: 16px;color: #000000;"> </span>""",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Card(
                    elevation: 1,
                    child: SizedBox(
                      height: 150,
                      width: Get.size.width,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("NOM DU RESPONSABLE"),
                            subtitle: Text("CHRISTIAN"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone_android),
                            title: Text("TELEPHONE"),
                            subtitle: Text("+243 778 778 9988"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ADRESSE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    """sur l’avenue de la Science, au n°7 dans la Commune de la Gombe, quartier Haut commandement à Kinshasa, Capitale de la République Démocratique du Congo""",
                  ),
                ],
              )
            : ie.value == 1
                ? ListView(
                    padding: const EdgeInsets.all(10),
                    children: const [],
                  )
                : ie.value == 2
                    ? ListView(
                        padding: const EdgeInsets.all(10),
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ATTRIBUT. & MISSION",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          HtmlWidget(
                              """ La mission principale assignée par le Ministère de l'EPST est celle de former la jeunesse, par une éducation perméable à toutes les catégories sociales, afin de combattre le phénomène d’analphabétisme sur toute l’étendue du territoire national et faire de chaque Enfant Congolais un élève complet, un citoyen honnête, consciencieux et utile à la société.
En effet, les attributions de la Direction de la Planification et des Statistiques Scolaires (DPSS) devenue aujourd'hui la Direction de l'Information pour la Gestion de l'Education, en sigle: "DIGE" se trouvent être définie  dans l'arrêté ministériel n° EDN/DG/3156/75 du 30 octobre 1975, révisé en 1990 par le numéro MIN EPSP/CABMN/ 001/01488/90 du 31/12/1990, en 1992 par le numéro 02326/42 DU 14/08/1992,et très récemment en 2017 dans le cadre de la mise en œuvre de la stratégie de la Réforme et Modernisation de l’Administration publique (CPMAP), en application du décret N°15/043 du 28 décembre 2015 faisant suite à l’Arrêté n° CAB .MIN/FP/J-CK/SGA/ CMRAP/JSB/GMK/013/2015 du 30 juillet 2015 portant fixation du cadre organique des structures standards à compétences horizontales communes à toutes les administrations centrales des ministères, institutions et services publics. 
A cet effet, On reconnait à la DIGE la mission de :

1. Constituer ou Collecter, traiter et publier les statistiques officielles de l’enseignement pré-primaire, primaire et secondaire ;
2. Gérer le système d’information du Ministère de l’Enseignement Primaire, Secondaire et Technique ;  
3. Elaborer et produire le rapport d’indicateurs statistiques scolaires ;
4. Assurer l’élaboration de la carte scolaire et réaliser des analyses sur la répartition spatiale de l’offre scolaire enfin d’établir des prévisions de ressources humaines, financières, budgétaires et scolaires ;
5. Coordonner et assurer le suivi de la mise en œuvre des objectifs de développement durable (ODD);
6. Implanter, Coordonner les Cellules Provinciales pour les statistiques de l’Education (CTPSE) et assurer le suivi de la mise en œuvre du programme de la décentralisation du SIGE.
""")
                        ],
                      )
                    : ie.value == 3
                        ? ListView(
                            padding: const EdgeInsets.all(10),
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "REALISATIONS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              HtmlWidget(
                                  """La DIGE Coordonne le Système d'information pour la gestion de l'Education (SIGE) et gère tous les projets et programmes ayant trait à la production des données statistiques de l'éducation.  Ainsi, son importance se trouve dans sa mission de production des statistiques. Elle produit chaque année les annuaires statistiques contenant les données (indicateurs mesurables et utilisables) utiles pour la gestion et le pilotage du système éducatif.

Comme nous pouvons le savoir, la statistique est l'étude de la collecte de données, leur analyse, leur traitement, l'interprétation des résultats et leur présentation de manière à les rendre plus compréhensibles par tous. C'est à la fois une science, une méthode et un ensemble de techniques.
Nous devons savoir que le Ministère de l’EPST/2021 avec ses 106 310 écoles & 809 656 groupes pédagogiques, ses 945 176 enseignants et 26 196 775 élèves, accorde une grande importance à la production des données statistiques pour réussir au mieux sa planification afin de bien gérer et piloter tout son système éducatif.

Les statistiques sont utiles pour une gestion efficace du sous-secteur de l’éducation tant au niveau des écoles, des sous-divisions, des divisions ou provinces éducationnelles que hors ses frontières.

• Les statistiques fiables sont utiles pour une bonne planification du sous-secteur à ses différentes phases : le diagnostic, l’identification des problèmes, la fixation des objectifs à atteindre à court terme, à moyen terme et à long terme, le suivi de la mise en œuvre et l’évaluation de ses projets.
• Les statistiques sont utiles pour le suivi-évaluation des projets/programmes stratégiques basés sur l’accès & équité, la qualité & pertinence et la bonne gouvernance)
• Les statistiques sont utiles pour mener ou réaliser des études sur le système éducatif, comme : RESEN, PASEC, Enquête EADE, etc,….
• Les statistiques aident à la prise des décisions rationnelles pour le développement du sous-secteur. 
• Les statistiques sont des outils nécessaires pour le suivi-évaluation des engagements internationaux auxquels le pays a souscrit : 
-Objectif de l’EPT en 1990
-OMD en 2000 
-ODD en 2015 horizon 2030
-Bref, les statistiques sont importantes pour les décideurs, les gestionnaires, les planificateurs et les chercheurs au regard des indicateurs disponibles considérés comme des outils permettant de mesurer l’état de santé d’un système éducatif.
""")
                            ],
                          )
                        : ListView(
                            padding: const EdgeInsets.all(10),
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "HISTORIQUES",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              HtmlWidget("""1. Introduction 
La Direction de l'Information pour la Gestion de l'Education (DIGE) reconnue successivement sous les appellations EDN, DPSS et DEP, respectivement : Cellule des statistique (EDN), Direction de la Planification et des Statistiques Scolaires (DPSS) et Direction d'Etudes & de la Planification (DEP). 
En effet, cette Direction fonctionne depuis sa création en 1961 antérieurement sous l’appellation de la Cellule des statistique (EDN) depuis 1964, elle est devenue l’objet d’une évolution progressive portant des périodes en période une appellation relative à la fonction dévolue et plusieurs chefs se sont succédé à sa gestion. C'est donc par l’arrêté ministériel n° EDN/DG/3156/75 du 30 octobre 1975 qu’elle sera baptisée « Direction de la Planification et des Statistiques Scolaires (DPSS) » et aujourd’hui suite à la mise en œuvre de la stratégie de la Réforme et Modernisation de l’Administration publique, cédera quelques de ses anciennes attributions à l’actuelle Direction « DEP des services Standards » pour finalement rester dans sa vocation de productrice des données Statistiques. D'où l'actuelle appellation de la "Direction de l'Information pour la Gestion de l'Education". 
2. Evolution de la cellule des statistiques (E.D.N) aujourd'hui DIGE
A sa création en 1961, elle est conçue comme Cellule des statistiques (E.D.N), fonctionnant au sein de l’inspection générale de l’éducation nationale, règlementé par Monsieur HUBER LUKUNDA, dont le mérite lui ont value à nos jours, le titre honorifique du secrétaire générale.   
• De 1961 à 1964 : cellule d’études et planification La cellule des statistiques avait été transformée en cellule d’études et planification ;
• De 1964 à 1968 : Bureau des Statistiques. Durant cette période, la cellule d’études et planification est devenue Bureau des statistiques de l’Education National au sein de la Direction des Services Pédagogiques. Le Directeur chef de service était Monsieur ANDRE KAMBUA. 
• De 1968 à 1973 : Direction générale de planification, sous la direction de Monsieur JONAS MUKALAYI WA NKULU. Les Bureaux des statistiques s’érigent en direction générale de la planification où les cadres affectés sont régentés par la direction   générale de l’éducation nationale étant sous la juridiction de monsieur JONAS MUKALAYI WA NKULU lui-même. 
• De 1973 à 1982 : Direction générale de la planification et des statistiques. Au cours de cette période, la direction générale de la planification est assimilée à la direction générale de planification et des statistiques, chargée de prélever les statistiques du prés-scolaire, du primaire, du secondaire (toutes les options), du supérieur et universitaire, ainsi que des écoles médicales (tout niveau). Notons cependant que la rétrocession des écoles médicales au ministère de la santé intervient en 1976.  
D’où le prélèvement des statistiques de l’enseignement supérieur et universitaire ne relève plus de cette direction.
• De 1982 à 1983 : La direction est divisée en deux directions :
La direction de planification de l’enseignement maternel et de l’enseignement primaire dirigée par monsieur JOSEPH MOSANGU.
La direction de la planification de l’enseignement secondaire dirigé par monsieur JOSEPH KUFIKILANGA.
• En 1983, à la suite d’une mise en place générale de la fonction publique, Monsieur JOSEPH MUSANGU LUBILANJI devient Directeur de la Direction de la Planification, mais il est mis en retraite en 1983
• De 1983 à 1988  : Monsieur CHARLES ILUNGA MFUKI KABAMBI
• De 1988 à 1995  : Monsieur LAMBERT LWAMBA LWA NEMBA
• De 1995 à 2002 : Monsieur SAMY NKOYO-A-NZOLA (intérimaire)
• De 2002 à 2021 : Monsieur FRANÇOIS KUBINDILAKI KAPAY
• De 2001 à 2022 : Monsieur Roger VIMINDE KOTAKOLI (intérimaire)
• De 2022 à ce jour : Monsieur Cédric WAKANDWA WANTUKASAMBA
• Depuis 2001 la Direction de la Planification et des Statistiques Scolaires est devenue Direction d’Etudes et Planification (DEP) Circulaire n° CAB. MIN/FP/MK/kit/1109/2001/du 7/09/2001 du Ministère de la Fonction Publique. 
"""),
                            ],
                          ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (e) {
            //
            ie.value = e;
            //
          },
          currentIndex: ie.value,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey.shade700,
          backgroundColor: Colors.grey.shade200,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_rounded), label: "DETAILS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_rounded), label: "DEPARTEMENTS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_document), label: "ARRETS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.text_fields), label: "ATT. & MISSION"),
            BottomNavigationBarItem(
                icon: Icon(Icons.work), label: "REALISATIONS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "HISTORIQUES"),
          ],
        ),
      ),
    );
  }
}
