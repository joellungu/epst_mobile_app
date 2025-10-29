import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AnnoncesSwiper extends StatefulWidget {
  @override
  State<AnnoncesSwiper> createState() => _AnnoncesSwiperState();
}

class _AnnoncesSwiperState extends State<AnnoncesSwiper> {
  //
  final controller = SwiperController();
  late Future<List<String>> _annoncesFuture;

  Timer? timer;
  init() {
    timer = Timer.periodic(const Duration(seconds: 5), (c) {
      print("temps: ${c.tick}");
      controller.next();
      //pageController.nextPage(
      //  duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  void initState() {
    super.initState();
    _annoncesFuture = loadAnnonces();
    //
    init();
  }

  @override
  void dispose() {
    //
    timer!.cancel();
    //
    super.dispose();
    //
  }

  Future<List<String>> loadAnnonces() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/annonces_cache.json');

    // Vérifie la connexion Internet
    final connectivity = await Connectivity().checkConnectivity();
    final bool hasConnection = connectivity != ConnectivityResult.none;

    List<String> cachedIds = [];

    // Charger les anciennes annonces du cache s'il existe
    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      cachedIds = List<String>.from(data);
    }

    if (!hasConnection) {
      debugPrint("📴 Pas de connexion - utilisation du cache local");
      return cachedIds;
    }

    try {
      final response =
          await http.get(Uri.parse("${Connexion.lien}annonce/all"));
      if (response.statusCode == 200) {
        final List<dynamic> list = jsonDecode(response.body);
        final List<String> serverIds = list.map((e) => e.toString()).toList();

        // 🧹 Supprimer les annonces qui n'existent plus sur le serveur
        final removedIds =
            cachedIds.where((id) => !serverIds.contains(id)).toList();

        if (removedIds.isNotEmpty) {
          debugPrint(
              "🗑️ Suppression locale de ${removedIds.length} images obsolètes...");
          await _deleteCachedImages(removedIds);
        }

        // 💾 Mise à jour du cache si changement
        if (!listEquals(serverIds, cachedIds)) {
          await file.writeAsString(jsonEncode(serverIds));
          debugPrint("💾 Cache mis à jour (${serverIds.length} images)");
        }

        return serverIds;
      } else {
        debugPrint("⚠️ Erreur serveur ${response.statusCode}");
        return cachedIds;
      }
    } catch (e) {
      debugPrint("⚠️ Erreur: $e");
      return cachedIds;
    }
  }

  /// Supprime les images correspondantes aux IDs données du cache de CachedNetworkImage
  Future<void> _deleteCachedImages(List<String> ids) async {
    final cacheManager = DefaultCacheManager();

    for (final id in ids) {
      final url = "${Connexion.lien}annonce/image?id=$id";
      await cacheManager.removeFile(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: FutureBuilder<List<String>>(
        future: _annoncesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erreur de chargement"));
          }

          final list = snapshot.data ?? [];

          if (list.isEmpty) {
            return const Center(child: Text("Aucune annonce disponible"));
          }

          return Swiper(
            controller: controller,
            itemCount: list.length,
            duration: 2000,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemBuilder: (context, index) {
              final url = "${Connexion.lien}annonce/image?id=${list[index]}";
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, _) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, _, __) => const Icon(Icons.broken_image,
                    size: 40, color: Colors.grey),
              );
            },
          );
        },
      ),
    );
  }
}
