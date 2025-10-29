import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  //
  NoConnectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off, size: 70, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  "Pas de connexion Internet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Vérifie ton Wi-Fi ou tes données mobiles.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // ElevatedButton.icon(
                //   onPressed: () async {
                //     final result = await Connectivity().checkConnectivity();
                //     final connected = result != ConnectivityResult.none;
                //     if (!connected) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text("Toujours pas de connexion 😬"),
                //         ),
                //       );
                //     } else {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (_) => page,
                //         ),
                //       );
                //     }
                //   },
                //   icon: const Icon(Icons.refresh),
                //   label: const Text("Réessayer"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
