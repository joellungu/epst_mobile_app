import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/bibliotheques/models/bibliotheque_classe.dart';
import 'package:epst_app/vues/bibliotheques/models/bibliotheque_cours.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BibliothequeService {
  static const String _allCoursesKey = 'bibliotheque.cours.all';
  static const String _lastUpdateKey = 'bibliotheque.last_update';

  final GetStorage _box = GetStorage();
  final http.Client _client;

  BibliothequeService({http.Client? client}) : _client = client ?? http.Client();

  Future<bool> isConnected() async {
    final dynamic result = await Connectivity().checkConnectivity();
    if (result is List<ConnectivityResult>) {
      return !result.contains(ConnectivityResult.none);
    }
    return result != ConnectivityResult.none;
  }

  Future<List<BibliothequeCours>> getCachedCourses() async {
    final stored = _box.read(_allCoursesKey);
    if (stored is List) {
      return stored
          .whereType<Map>()
          .map((e) => BibliothequeCours.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  Future<List<BibliothequeCours>> refreshCoursesIfConnected() async {
    if (!await isConnected()) {
      return getCachedCourses();
    }

    final response = await _client
        .get(Uri.parse('${Connexion.lien}cours/all'))
        .timeout(const Duration(minutes: 2));

    if (response.statusCode != 200 && response.statusCode != 201) {
      return getCachedCourses();
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      return getCachedCourses();
    }

    final courses = decoded
        .whereType<Map>()
        .map((e) {
          final data = Map<String, dynamic>.from(e);
          data.remove('data');
          return BibliothequeCours.fromJson(data);
        })
        .where((cours) => cours.id > 0)
        .toList();

    await _box.write(_allCoursesKey, courses.map((e) => e.toJson()).toList());
    await _box.write(_lastUpdateKey, DateTime.now().toIso8601String());
    return courses;
  }

  Future<List<BibliothequeClasse>> getClasses(String propriete) async {
    final allCourses = await refreshCoursesIfConnected();
    final courses = allCourses
        .where((cours) =>
            cours.propriete.isEmpty ||
            _samePropriete(cours.propriete, propriete))
        .toList();
    final grouped = <String, List<Map<String, dynamic>>>{};

    for (final cours in courses) {
      final idClasse = cours.idClasse.isEmpty ? 'sans-classe' : cours.idClasse;
      grouped.putIfAbsent(idClasse, () => []).add(cours.toJson());
    }

    final classes = grouped.values
        .where((courses) => courses.isNotEmpty)
        .map(BibliothequeClasse.fromCourses)
        .toList();

    classes.sort((a, b) => a.nom.toLowerCase().compareTo(b.nom.toLowerCase()));
    return classes;
  }

  Future<List<BibliothequeCours>> getCoursesByClass(
    String idClasse,
    String propriete,
  ) async {
    final cachedCourses = await getCachedCourses();
    var courses = cachedCourses.where((e) {
      final courseClassId = e.idClasse.isEmpty ? 'sans-classe' : e.idClasse;
      return courseClassId == idClasse &&
          (e.propriete.isEmpty || _samePropriete(e.propriete, propriete));
    }).toList();

    if (await isConnected() && idClasse.isNotEmpty && idClasse != 'sans-classe') {
      final uri = Uri.parse('${Connexion.lien}cours/allcours').replace(
        queryParameters: {
          'idClasse': idClasse,
          'typeFormation': propriete,
        },
      );
      final response = await _client.get(uri).timeout(const Duration(minutes: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        if (decoded is List) {
          courses = decoded.whereType<Map>().map((e) {
            final data = Map<String, dynamic>.from(e);
            data.remove('data');
            return BibliothequeCours.fromJson(data);
          }).toList();
          await _mergeCourses(courses);
        }
      }
    }

    courses.sort((a, b) => a.titre.toLowerCase().compareTo(b.titre.toLowerCase()));
    return courses;
  }

  bool _samePropriete(String first, String second) {
    return first.trim().toLowerCase() == second.trim().toLowerCase();
  }

  Future<File> getOrDownloadCourseFile(BibliothequeCours cours) async {
    final file = await localFileFor(cours);
    if (await file.exists() && await file.length() > 0) {
      return file;
    }

    if (!await isConnected()) {
      throw Exception("Ce cours n'est pas encore disponible hors connexion.");
    }

    final uri = Uri.parse('${Connexion.lien}cours/media').replace(
      queryParameters: {'id': '${cours.id}'},
    );
    final response = await _client.get(uri).timeout(const Duration(minutes: 3));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Le fichier du cours est introuvable.');
    }

    await file.parent.create(recursive: true);
    return file.writeAsBytes(response.bodyBytes, flush: true);
  }

  Future<File> localFileFor(BibliothequeCours cours) async {
    final directory = await _bibliothequeDirectory();
    return File(p.join(directory.path, 'cours_${cours.id}.${cours.extension}'));
  }

  String? get lastUpdateLabel {
    final value = _box.read(_lastUpdateKey);
    if (value is! String) {
      return null;
    }
    final date = DateTime.tryParse(value);
    if (date == null) {
      return null;
    }
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<Directory> _bibliothequeDirectory() async {
    final documents = await getApplicationDocumentsDirectory();
    return Directory(p.join(documents.path, 'bibliotheque'));
  }

  Future<void> _mergeCourses(List<BibliothequeCours> newCourses) async {
    final all = await getCachedCourses();
    final byId = <int, BibliothequeCours>{for (final cours in all) cours.id: cours};
    for (final cours in newCourses) {
      byId[cours.id] = cours;
    }
    await _box.write(_allCoursesKey, byId.values.map((e) => e.toJson()).toList());
    await _box.write(_lastUpdateKey, DateTime.now().toIso8601String());
  }
}
