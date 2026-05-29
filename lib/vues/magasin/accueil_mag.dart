import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/vues/actualite/site.dart';
import 'package:epst_app/vues/magasin/magasine.dart';
import 'package:epst_app/widgets/noConnectingPage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccueilMag extends StatefulWidget {
  const AccueilMag({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccueilMag();
  }
}

class _AccueilMag extends State<AccueilMag> {
  bool _isConnected = true;
  late final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkConnection();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final connected =
        results.any((result) => result != ConnectivityResult.none);
    if (!mounted || _isConnected == connected) {
      return;
    }
    setState(() => _isConnected = connected);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Magasin"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: const [
                Tab(text: 'Actualité'),
                Tab(text: 'Magasin'),
                Tab(text: 'Emission'),
                Tab(text: 'Nouvelle citoyenneté'),
              ],
            ),
            const SizedBox(height: 10),
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
}

class Emmission extends StatefulWidget {
  const Emmission({Key? key}) : super(key: key);

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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://youtube.com')) {
              debugPrint('Blocage : ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://www.youtube.com/playlist?list=PLG6Y1Tv0uHt_9ROdQyq5UmxaMtx6iWCSr',
        ),
      );
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
      floatingActionButton: FloatingActionButton(
        tooltip: "Rafraîchir",
        onPressed: _controller.reload,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class NvCitoyen extends StatefulWidget {
  const NvCitoyen({Key? key}) : super(key: key);

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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://youtube.com')) {
              debugPrint('Blocage : ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://www.youtube.com/playlist?list=PLG6Y1Tv0uHt9-ljcs0JyTe_w4gcLRz3Oz',
        ),
      );
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
      floatingActionButton: FloatingActionButton(
        tooltip: "Rafraîchir",
        onPressed: _controller.reload,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
