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
  static const String _allClassesKey = 'bibliotheque.classes.all';
  static const String _lastUpdateKey = 'bibliotheque.last_update';

  final GetStorage _box = GetStorage();
  final http.Client _client;

  BibliothequeService({http.Client? client})
      : _client = client ?? http.Client();

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
          .where((cours) => !cours.isZip)
          .toList();
    }
    return [];
  }

  Future<List<BibliothequeCours>> refreshCoursesIfConnected() async {
    if (!await isConnected()) {
      return getCachedCourses();
    }

    try {
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
          .where((cours) => cours.id > 0 && !cours.isZip)
          .toList();

      await _box.write(_allCoursesKey, courses.map((e) => e.toJson()).toList());
      await _box.write(_lastUpdateKey, DateTime.now().toIso8601String());
      return courses;
    } catch (_) {
      return getCachedCourses();
    }
  }

  Future<List<BibliothequeClasse>> getCachedClasses() async {
    final stored = _box.read(_allClassesKey);
    if (stored is List) {
      return stored
          .whereType<Map>()
          .map((e) => BibliothequeClasse.fromJson(
                Map<String, dynamic>.from(e),
                totalCours: _asInt(e['totalCours']),
              ))
          .where((classe) => classe.id.isNotEmpty)
          .toList();
    }
    return [];
  }

  Future<List<BibliothequeClasse>> refreshClassesIfConnected() async {
    if (!await isConnected()) {
      return getCachedClasses();
    }

    try {
      final response = await _client
          .get(Uri.parse('${Connexion.lien}classes'))
          .timeout(const Duration(minutes: 2));

      if (response.statusCode != 200 && response.statusCode != 201) {
        return getCachedClasses();
      }

      final decoded = jsonDecode(response.body);
      final rawClasses = decoded is List
          ? decoded
          : decoded is Map
              ? decoded['data'] ??
                  decoded['classes'] ??
                  decoded['content'] ??
                  decoded['items'] ??
                  const []
              : const [];

      if (rawClasses is! List) {
        return getCachedClasses();
      }

      final classes = rawClasses
          .whereType<Map>()
          .map((e) => BibliothequeClasse.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .where((classe) => classe.id.isNotEmpty)
          .toList();

      await _box.write(_allClassesKey, classes.map((e) => e.toJson()).toList());
      await _box.write(_lastUpdateKey, DateTime.now().toIso8601String());
      return classes;
    } catch (_) {
      return getCachedClasses();
    }
  }

  Future<List<BibliothequeClasse>> getClasses(
    String propriete, {
    bool refresh = false,
  }) async {
    final cachedCourses = await getCachedCourses();
    final cachedClasses = await getCachedClasses();
    final connected = await isConnected();
    final allCourses = refresh || cachedCourses.isEmpty
        ? await refreshCoursesIfConnected()
        : cachedCourses;
    final allClasses = refresh || cachedClasses.isEmpty || connected
        ? await refreshClassesIfConnected()
        : cachedClasses;
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

    final classesById = <String, BibliothequeClasse>{
      for (final classe in allClasses) classe.id: classe,
    };

    for (final entry in grouped.entries) {
      final classeFromCourses = BibliothequeClasse.fromCourses(entry.value);
      classesById[entry.key] =
          (classesById[entry.key] ?? classeFromCourses).copyWith(
        totalCours: entry.value.length,
      );
    }

    final classes = classesById.values.toList();
    classes.sort((a, b) => a.nom.toLowerCase().compareTo(b.nom.toLowerCase()));
    return classes;
  }

  Future<List<BibliothequeCours>> getCoursesByClass(
    String idClasse,
    String propriete, {
    bool refresh = false,
  }) async {
    final cachedCourses = await getCachedCourses();
    final connected = await isConnected();
    var courses = cachedCourses.where((e) {
      final courseClassId = e.idClasse.isEmpty ? 'sans-classe' : e.idClasse;
      return courseClassId == idClasse &&
          (e.propriete.isEmpty || _samePropriete(e.propriete, propriete));
    }).toList();

    if ((refresh || (connected && courses.isEmpty)) &&
        connected &&
        idClasse.isNotEmpty &&
        idClasse != 'sans-classe') {
      final uri = Uri.parse('${Connexion.lien}cours/allcours').replace(
        queryParameters: {
          'idClasse': idClasse,
          'typeFormation': propriete,
        },
      );
      try {
        final response =
            await _client.get(uri).timeout(const Duration(minutes: 2));
        if (response.statusCode == 200 || response.statusCode == 201) {
          final decoded = jsonDecode(response.body);
          if (decoded is List) {
            courses = decoded
                .whereType<Map>()
                .map((e) {
                  final data = Map<String, dynamic>.from(e);
                  data.remove('data');
                  return BibliothequeCours.fromJson(data);
                })
                .where((cours) => !cours.isZip)
                .toList();
            await _mergeCourses(courses);
          }
        }
      } catch (_) {
        courses = cachedCourses.where((e) {
          final courseClassId = e.idClasse.isEmpty ? 'sans-classe' : e.idClasse;
          return courseClassId == idClasse &&
              (e.propriete.isEmpty || _samePropriete(e.propriete, propriete));
        }).toList();
      }
    }

    courses
        .sort((a, b) => a.titre.toLowerCase().compareTo(b.titre.toLowerCase()));
    return courses;
  }

  bool _samePropriete(String first, String second) {
    return first.trim().toLowerCase() == second.trim().toLowerCase();
  }

  Future<File> getOrDownloadCourseFile(BibliothequeCours cours) async {
    if (cours.isZip) {
      throw Exception(
          "Les fichiers ZIP ne sont pas disponibles dans la bibliotheque.");
    }

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
    final byId = <int, BibliothequeCours>{
      for (final cours in all) cours.id: cours
    };
    for (final cours in newCourses) {
      if (!cours.isZip) {
        byId[cours.id] = cours;
      }
    }
    await _box.write(
        _allCoursesKey, byId.values.map((e) => e.toJson()).toList());
    await _box.write(_lastUpdateKey, DateTime.now().toIso8601String());
  }

  int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse('${value ?? 0}') ?? 0;
  }
}
