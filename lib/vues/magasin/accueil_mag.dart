import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/vues/actualite/clin_oeil.dart';
import 'package:epst_app/vues/actualite/site.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/widgets/noConnectingPage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccueilMag extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _AccueilMag();
  }
  //
}

class _AccueilMag extends State<AccueilMag> {
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

  @override
  void initState() {
    super.initState();
    //
    _connectivity = Connectivity();
    //
    _checkConnection();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 4, // Nombre d'onglets pour chaque TabBar
      child: Scaffold(
        appBar: AppBar(
          title: Text("Magasin"),
          centerTitle: true,
        ),
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
                Tab(text: 'Actualité'),
                Tab(text: 'Magasin'),
                Tab(text: 'Emission'),
                Tab(text: 'Nouvelle citoyenneté'),
              ],
            ),
            const SizedBox(height: 10),
            // TabBarView pour le contenu
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _isConnected ? Actualites() : NoConnectionPage(),
                  Magasine(
                    type: 1,
                    localData: _isConnected,
                  ),
                  _isConnected ? Emmission() : NoConnectionPage(),
                  _isConnected ? NvCitoyen() : NoConnectionPage(),
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

class Emmission extends StatefulWidget {
  @override
  State<Emmission> createState() => _Emmission();
}

class _Emmission extends State<Emmission> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // autoriser JS
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Exemple : bloquer certains sites
            if (request.url.startsWith('https://youtube.com')) {
              debugPrint('Blocage : ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.youtube.com/playlist?list=PLG6Y1Tv0uHt_9ROdQyq5UmxaMtx6iWCSr'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final url = await _controller.currentUrl();
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('URL actuelle : $url')),
      //     );
      //   },
      //   child: const Icon(Icons.link),
      // ),
    );
  }
}

class NvCitoyen extends StatefulWidget {
  @override
  State<NvCitoyen> createState() => _NvCitoyen();
}

class _NvCitoyen extends State<NvCitoyen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // autoriser JS
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Exemple : bloquer certains sites
            if (request.url.startsWith('https://youtube.com')) {
              debugPrint('Blocage : ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.youtube.com/playlist?list=PLG6Y1Tv0uHt9-ljcs0JyTe_w4gcLRz3Oz'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final url = await _controller.currentUrl();
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('URL actuelle : $url')),
      //     );
      //   },
      //   child: const Icon(Icons.link),
      // ),
    );
  }
}
