import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/vues/ige/ige.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/vues/sg/sg.dart';
import 'package:epst_app/widgets/noConnectingPage.dart';
import 'package:flutter/material.dart';

class AccueilSg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _AccueilSg();
  }
}

class _AccueilSg extends State<AccueilSg> {
  //
  bool _isConnected = false;
  late Connectivity _connectivity;
  late final Stream<ConnectivityResult> _stream;
  //

  Future<void> _checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    final connected = results.any((r) => r != ConnectivityResult.none);
    setState(() => _isConnected = connected);

    // On écoute les changements en direct
    _connectivity.onConnectivityChanged.listen((results) {
      final connected = results.any((r) => r != ConnectivityResult.none);
      setState(() => _isConnected = connected);
    });
  }

  //
  @override
  void initState() {
    super.initState();
    //
    _connectivity = Connectivity();
    //
    _checkConnection();
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 3, // Nombre d'onglets pour chaque TabBar
      child: Scaffold(
        body: Column(
          children: [
            // TabBar 1
            TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelStyle: TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(text: 'Secretariat général'),
                Tab(text: 'Statistiques'),
                Tab(text: 'Documents admin'),
              ],
            ),
            const SizedBox(height: 10),
            // TabBarView pour le contenu
            Expanded(
              child: TabBarView(
                children: [
                  _isConnected ? SecretariaGeneral() : NoConnectionPage(),
                  _isConnected
                      ? Center(child: Text('Contenu Tab 2'))
                      : NoConnectionPage(),
                  Magasine(
                    type: 3,
                    localData: _isConnected,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
}
