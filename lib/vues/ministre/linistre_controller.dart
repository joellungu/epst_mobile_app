import 'dart:convert';

import 'package:epst_app/main.dart';
import 'package:epst_app/utils/connexion.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MinistreController extends GetxController {
  static const String allLabel = 'Tout';

  final RxBool loading = false.obs;
  final RxBool explorerLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedProvince = ''.obs;
  final RxString selectedVille = ''.obs;
  final RxString selectedCleEcole = ''.obs;
  final RxString selectedEcoleName = ''.obs;
  final RxString explorerType = 'students'.obs;
  final Rx<AnalyticsSummary?> summary = Rx<AnalyticsSummary?>(null);
  final RxMap<String, AnalyticsChart> charts = <String, AnalyticsChart>{}.obs;
  final RxMap<String, AnalyticsChart> explorerCharts =
      <String, AnalyticsChart>{}.obs;
  final RxList<GeoStat> provinces = <GeoStat>[].obs;
  final RxList<GeoStat> villes = <GeoStat>[].obs;
  final RxList<GeoStat> ecoles = <GeoStat>[].obs;
  final RxList<EntityListItem> entities = <EntityListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    loading.value = true;
    errorMessage.value = '';
    try {
      final Map<String, dynamic> filter = {
        if (annee.value.trim().isNotEmpty) 'anneescolaire': annee.value.trim(),
        if (selectedProvince.value.isNotEmpty)
          'province': selectedProvince.value,
        if (selectedVille.value.isNotEmpty) 'ville': selectedVille.value,
        if (selectedCleEcole.value.isNotEmpty)
          'cleEcole': selectedCleEcole.value,
        'limit': 8,
        'offset': 0,
        'seuilReussite': 50.0,
      };

      final results = await Future.wait([
        _post('/analytics/summary', filter),
        _post('/analytics/students/by-class', filter),
        _post('/analytics/students/by-sex', filter),
        _post('/analytics/students/success-by-sex', filter),
        _post('/analytics/teachers/by-type', filter),
        _post('/analytics/admin-staff/by-function', filter),
        _post('/analytics/schools/by-province', filter),
        _post('/analytics/students/top-schools', filter),
      ]);

      summary.value = AnalyticsSummary.fromJson(
          Map<String, dynamic>.from(results[0] as Map));
      charts.assignAll({
        'studentsByClass': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[1] as Map)),
        'studentsBySex': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[2] as Map)),
        'studentSuccessBySex': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[3] as Map)),
        'teachersByType': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[4] as Map)),
        'adminByFunction': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[5] as Map)),
        'schoolsByProvince': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[6] as Map)),
        'schoolEffectifs': AnalyticsChart.fromJson(
            Map<String, dynamic>.from(results[7] as Map)),
      });
      await loadGeoFilters();
      await loadExplorerCharts();
    } catch (e) {
      errorMessage.value =
          "Impossible de charger les statistiques. Verifiez le serveur analytics.";
    } finally {
      loading.value = false;
    }
  }

  Future<void> loadGeoFilters() async {
    try {
      final data = await _postList(
        '/analytics/provinces',
        _filter(
          limit: 200,
          includeProvince: false,
          includeVille: false,
          includeEcole: false,
        ),
      );
      provinces.assignAll(data
          .map((e) => GeoStat.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList());
    } catch (e) {
      provinces.clear();
    }

    try {
      final data = await _postList(
        '/analytics/villes',
        _filter(
          limit: 300,
          includeProvince: true,
          includeVille: false,
          includeEcole: false,
        ),
      );
      villes.assignAll(data
          .map((e) => GeoStat.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList());
    } catch (e) {
      villes.clear();
    }

    try {
      final data = await _postList(
        '/analytics/ecoles',
        _filter(
          limit: 500,
          includeProvince: true,
          includeVille: true,
          includeEcole: false,
        ),
      );
      ecoles.assignAll(data
          .map((e) => GeoStat.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList());
    } catch (e) {
      ecoles.clear();
    }
  }

  Future<void> applyProvince(String value) async {
    selectedProvince.value = value == allLabel ? '' : value;
    selectedVille.value = '';
    selectedCleEcole.value = '';
    selectedEcoleName.value = '';
    await loadAnalytics();
  }

  Future<void> applyVille(String value) async {
    selectedVille.value = value == allLabel ? '' : value;
    selectedCleEcole.value = '';
    selectedEcoleName.value = '';
    await loadAnalytics();
  }

  Future<void> applyEcole(GeoStat value) async {
    if (value.cleEcole.isEmpty) {
      selectedCleEcole.value = '';
      selectedEcoleName.value = '';
      await loadAnalytics();
      return;
    }
    selectedCleEcole.value = value.cleEcole;
    selectedEcoleName.value = value.nomEcole;
    await loadAnalytics();
  }

  Future<void> clearFilters() async {
    selectedProvince.value = '';
    selectedVille.value = '';
    selectedCleEcole.value = '';
    selectedEcoleName.value = '';
    await loadAnalytics();
  }

  Future<void> changeExplorer(String type) async {
    explorerType.value = type;
    await loadExplorerCharts();
  }

  Future<void> loadExplorerCharts() async {
    explorerLoading.value = true;
    explorerCharts.clear();
    try {
      final filter = _filter(limit: 10);
      final paths = explorerType.value == 'teachers'
          ? <String, String>{
              'ageBands': '/analytics/teachers/age-bands',
              'byType': '/analytics/teachers/by-type',
              'byGrade': '/analytics/teachers/by-grade',
              'presenceBySchool': '/analytics/teachers/presence-by-school',
              'absenceBySchool': '/analytics/teachers/absence-by-school',
              'topCoursesHours': '/analytics/schools/top-courses-hours',
            }
          : explorerType.value == 'admin'
              ? <String, String>{
                  'ageBands': '/analytics/admin-staff/age-bands',
                  'byFunction': '/analytics/admin-staff/by-function',
                  'byDepartment': '/analytics/admin-staff/by-department',
                  'bySex': '/analytics/admin-staff/by-sex',
                }
              : <String, String>{
                  'ageBands': '/analytics/students/age-bands',
                  'averageAgeByClass':
                      '/analytics/students/average-age-by-class',
                  'presenceByClass': '/analytics/students/presence-by-class',
                  'absenceByClass': '/analytics/students/absence-by-class',
                  'bySchool': '/analytics/students/top-schools',
                  'topCoursesHours': '/analytics/schools/top-courses-hours',
                };

      final entries = await Future.wait(paths.entries.map((entry) async {
        try {
          final data = await _post(entry.value, filter);
          return MapEntry(
            entry.key,
            AnalyticsChart.fromJson(Map<String, dynamic>.from(data)),
          );
        } catch (e) {
          return null;
        }
      }));
      explorerCharts.assignAll(Map<String, AnalyticsChart>.fromEntries(
        entries.whereType<MapEntry<String, AnalyticsChart>>(),
      ));
    } catch (e) {
      explorerCharts.clear();
    } finally {
      explorerLoading.value = false;
    }
  }

  Future<void> searchEntities(
    String search,
    String type, {
    String? province,
    String? provinceEducationnelle,
    String? cleEcole,
  }) async {
    explorerLoading.value = true;
    try {
      final path = type == 'teachers'
          ? '/analytics/teachers'
          : type == 'admin'
              ? '/analytics/admin-staff'
              : '/analytics/students';
      final data = await _postList(
        path,
        _filter(
          limit: 25,
          search: search,
          province: province,
          provinceEducationnelle: provinceEducationnelle,
          cleEcole: cleEcole,
        ),
      );
      entities.assignAll(data
          .map((e) => EntityListItem.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      entities.clear();
    } finally {
      explorerLoading.value = false;
    }
  }

  Future<List<GeoStat>> searchSchools({
    String? search,
    String? province,
    String? provinceEducationnelle,
    int limit = 50,
  }) async {
    final data = await _postList(
      '/analytics/schools/search',
      _filter(
        limit: limit,
        search: search,
        province: province,
        provinceEducationnelle: provinceEducationnelle,
        includeVille: false,
        includeEcole: false,
      ),
    );
    return data
        .map((e) => GeoStat.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  void clearEntityResults() {
    entities.clear();
  }

  Future<Map<String, dynamic>> loadEntityDetail(EntityListItem item,
      {String? type}) {
    final entityType = type ?? explorerType.value;
    final path = entityType == 'teachers'
        ? '/analytics/teachers/${item.cle}/detail'
        : entityType == 'admin'
            ? '/analytics/admin-staff/${item.cle}/detail'
            : '/analytics/students/${item.cle}/detail';
    return _post(path, _filter(limit: 1));
  }

  Map<String, dynamic> _filter({
    int limit = 8,
    bool includeProvince = true,
    bool includeVille = true,
    bool includeEcole = true,
    String? search,
    String? province,
    String? provinceEducationnelle,
    String? cleEcole,
  }) {
    final resolvedProvince = province ?? selectedProvince.value;
    final resolvedCleEcole = cleEcole ?? selectedCleEcole.value;
    return {
      if (annee.value.trim().isNotEmpty) 'anneescolaire': annee.value.trim(),
      if (includeProvince && resolvedProvince.isNotEmpty)
        'province': resolvedProvince,
      if (provinceEducationnelle != null &&
          provinceEducationnelle.trim().isNotEmpty)
        'provinceEducationnelle': provinceEducationnelle.trim(),
      if (includeVille && selectedVille.value.isNotEmpty)
        'ville': selectedVille.value,
      if (includeEcole && resolvedCleEcole.isNotEmpty)
        'cleEcole': resolvedCleEcole,
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      'limit': limit,
      'offset': 0,
      'seuilReussite': 50.0,
    };
  }

  Future<Map<String, dynamic>> _post(
      String path, Map<String, dynamic> body) async {
    final response = await http
        .post(
          Uri.parse('${Connexion.lien2.replaceAll(RegExp(r"/+$"), "")}$path'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List> _postList(String path, Map<String, dynamic> body) async {
    final response = await http
        .post(
          Uri.parse('${Connexion.lien2.replaceAll(RegExp(r"/+$"), "")}$path'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
    return jsonDecode(response.body) as List;
  }
}

class GeoStat {
  final String province;
  final String provinceEducationnelle;
  final String ville;
  final String cleEcole;
  final String nomEcole;
  final double totalSchools;
  final double totalStudents;
  final double totalTeachers;
  final double totalAdminStaff;
  final double successRate;
  final double presenceRate;

  GeoStat({
    required this.province,
    required this.provinceEducationnelle,
    required this.ville,
    required this.cleEcole,
    required this.nomEcole,
    required this.totalSchools,
    required this.totalStudents,
    required this.totalTeachers,
    required this.totalAdminStaff,
    required this.successRate,
    required this.presenceRate,
  });

  factory GeoStat.fromJson(Map<String, dynamic> json) {
    return GeoStat(
      province: '${json['province'] ?? ''}',
      provinceEducationnelle: '${json['provinceEducationnelle'] ?? ''}',
      ville: '${json['ville'] ?? ''}',
      cleEcole: '${json['cleEcole'] ?? ''}',
      nomEcole: '${json['nomEcole'] ?? ''}',
      totalSchools: _num(json['totalSchools']),
      totalStudents: _num(json['totalStudents']),
      totalTeachers: _num(json['totalTeachers']),
      totalAdminStaff: _num(json['totalAdminStaff']),
      successRate: _num(json['successRate']),
      presenceRate: _num(json['presenceRate']),
    );
  }
}

class EntityListItem {
  final String cle;
  final String numeroIdentifiant;
  final String fullName;
  final String sexe;
  final String classe;
  final String fonction;
  final String departement;
  final String typeEnseignant;
  final String gradeActuel;
  final String anneescolaire;
  final String cleEcole;
  final String nomEcole;
  final String province;
  final String ville;

  EntityListItem({
    required this.cle,
    required this.numeroIdentifiant,
    required this.fullName,
    required this.sexe,
    required this.classe,
    required this.fonction,
    required this.departement,
    required this.typeEnseignant,
    required this.gradeActuel,
    required this.anneescolaire,
    required this.cleEcole,
    required this.nomEcole,
    required this.province,
    required this.ville,
  });

  factory EntityListItem.fromJson(Map<String, dynamic> json) {
    return EntityListItem(
      cle: '${json['cle'] ?? ''}',
      numeroIdentifiant: '${json['numeroIdentifiant'] ?? ''}',
      fullName: '${json['fullName'] ?? ''}',
      sexe: '${json['sexe'] ?? ''}',
      classe: '${json['classe'] ?? ''}',
      fonction: '${json['fonction'] ?? ''}',
      departement: '${json['departement'] ?? ''}',
      typeEnseignant: '${json['typeEnseignant'] ?? ''}',
      gradeActuel: '${json['gradeActuel'] ?? ''}',
      anneescolaire: '${json['anneescolaire'] ?? ''}',
      cleEcole: '${json['cleEcole'] ?? ''}',
      nomEcole: '${json['nomEcole'] ?? ''}',
      province: '${json['province'] ?? ''}',
      ville: '${json['ville'] ?? ''}',
    );
  }
}

class AnalyticsSummary {
  final AnalyticsKpi students;
  final AnalyticsKpi teachers;
  final AnalyticsKpi admin;
  final SchoolKpi schools;

  AnalyticsSummary({
    required this.students,
    required this.teachers,
    required this.admin,
    required this.schools,
  });

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) {
    return AnalyticsSummary(
      students: AnalyticsKpi.fromJson(json['students']),
      teachers: AnalyticsKpi.fromJson(json['teachers']),
      admin: AnalyticsKpi.fromJson(json['admin']),
      schools: SchoolKpi.fromJson(json['schools']),
    );
  }
}

class AnalyticsKpi {
  final double total;
  final double femalePercentage;
  final double malePercentage;
  final double averageAge;
  final double successRate;
  final double presenceRate;

  AnalyticsKpi({
    required this.total,
    required this.femalePercentage,
    required this.malePercentage,
    required this.averageAge,
    required this.successRate,
    required this.presenceRate,
  });

  factory AnalyticsKpi.fromJson(dynamic source) {
    final json = source is Map<String, dynamic> ? source : <String, dynamic>{};
    return AnalyticsKpi(
      total: _num(json['total']),
      femalePercentage: _num(json['femalePercentage']),
      malePercentage: _num(json['malePercentage']),
      averageAge: _num(json['averageAge']),
      successRate: _num(json['successRate']),
      presenceRate: _num(json['presenceRate']),
    );
  }
}

class SchoolKpi {
  final double total;
  final double provinces;
  final double cities;
  final double averageStudentsPerSchool;
  final double averageSuccessRate;
  final double averagePresenceRate;

  SchoolKpi({
    required this.total,
    required this.provinces,
    required this.cities,
    required this.averageStudentsPerSchool,
    required this.averageSuccessRate,
    required this.averagePresenceRate,
  });

  factory SchoolKpi.fromJson(dynamic source) {
    final json = source is Map<String, dynamic> ? source : <String, dynamic>{};
    return SchoolKpi(
      total: _num(json['total']),
      provinces: _num(json['provinces']),
      cities: _num(json['cities']),
      averageStudentsPerSchool: _num(json['averageStudentsPerSchool']),
      averageSuccessRate: _num(json['averageSuccessRate']),
      averagePresenceRate: _num(json['averagePresenceRate']),
    );
  }
}

class AnalyticsChart {
  final String title;
  final String type;
  final String unit;
  final List<AnalyticsPoint> points;

  AnalyticsChart({
    required this.title,
    required this.type,
    required this.unit,
    required this.points,
  });

  bool get isEmpty => points.isEmpty;

  factory AnalyticsChart.fromJson(Map<String, dynamic> json) {
    final labels = json['labels'] is List ? json['labels'] as List : const [];
    final values = json['values'] is List ? json['values'] as List : const [];
    final length =
        labels.length < values.length ? labels.length : values.length;

    return AnalyticsChart(
      title: '${json['title'] ?? ''}',
      type: '${json['type'] ?? 'bar'}',
      unit: '${json['unit'] ?? ''}',
      points: List.generate(length, (index) {
        return AnalyticsPoint('${labels[index]}', _num(values[index]));
      }),
    );
  }
}

class AnalyticsPoint {
  final String label;
  final double value;

  AnalyticsPoint(this.label, this.value);
}

double _num(dynamic value) {
  if (value == null) {
    return 0;
  }
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse('$value') ?? 0;
}
