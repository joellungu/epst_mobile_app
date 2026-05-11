import 'package:epst_app/vues/ministre/data/provinces_educationnelles_rdc.dart';
import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/entity_widgets.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntitySearchPage extends StatefulWidget {
  final MinistreController controller;
  final String initialType;

  const EntitySearchPage({
    Key? key,
    required this.controller,
    required this.initialType,
  }) : super(key: key);

  @override
  State<EntitySearchPage> createState() => _EntitySearchPageState();
}

class _EntitySearchPageState extends State<EntitySearchPage> {
  late String _type;
  late String _province;
  String _provinceEducationnelle = '';
  GeoStat? _selectedSchool;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _province = widget.controller.selectedProvince.value;
    if (widget.controller.selectedCleEcole.value.isNotEmpty) {
      for (final school in widget.controller.ecoles) {
        if (school.cleEcole == widget.controller.selectedCleEcole.value) {
          _selectedSchool = school;
          _provinceEducationnelle = school.provinceEducationnelle;
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Recherche individuelle'),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ministreBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'students', child: Text('Eleve')),
                      DropdownMenuItem(
                          value: 'teachers', child: Text('Enseignant')),
                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    ],
                    onChanged: (value) {
                      setState(() => _type = value ?? 'students');
                      widget.controller.clearEntityResults();
                    },
                  ),
                  const SizedBox(height: 10),
                  _ProvinceDropdown(
                    value: _province,
                    provinces: _provinces,
                    onChanged: (value) {
                      setState(() {
                        _province = value == MinistreController.allLabel
                            ? ''
                            : value ?? '';
                        _provinceEducationnelle = '';
                        _selectedSchool = null;
                      });
                      widget.controller.clearEntityResults();
                    },
                  ),
                  const SizedBox(height: 10),
                  _ProvinceEducationnelleDropdown(
                    value: _provinceEducationnelle,
                    provinces: _provinceEducationnelles,
                    onChanged: (value) {
                      setState(() {
                        _provinceEducationnelle =
                            value == MinistreController.allLabel
                                ? ''
                                : value ?? '';
                        _selectedSchool = null;
                      });
                      widget.controller.clearEntityResults();
                    },
                  ),
                  const SizedBox(height: 10),
                  _SchoolSearchField(
                    school: _selectedSchool,
                    onClear: () {
                      setState(() => _selectedSchool = null);
                      widget.controller.clearEntityResults();
                    },
                    onTap: _openSchoolSearch,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      labelText: 'Nom ou identifiant',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _runSearch(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _runSearch,
                      icon: const Icon(Icons.manage_search, size: 18),
                      label: const Text('Rechercher'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (widget.controller.explorerLoading.value)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (widget.controller.entities.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'Entrez un nom ou un identifiant pour afficher les resultats',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF607089)),
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: ministreBoxDecoration(),
                child: Column(
                  children: widget.controller.entities
                      .map(
                        (item) => EntityTile(
                          controller: widget.controller,
                          item: item,
                          entityType: _type,
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _runSearch() {
    widget.controller.searchEntities(
      _searchController.text,
      _type,
      province: _province,
      provinceEducationnelle: _provinceEducationnelle,
      cleEcole: _selectedSchool?.cleEcole,
    );
  }

  List<String> get _provinceEducationnelles {
    final referenceValues = _province.isEmpty
        ? provincesEducationnellesRdc.values.expand((items) => items)
        : provincesEducationnellesForProvince(_province);
    final schoolValues = widget.controller.ecoles
        .where((school) => _province.isEmpty || school.province == _province)
        .map((school) => school.provinceEducationnelle)
        .where((value) => value.isNotEmpty);
    final values = {
      ...referenceValues,
      ...schoolValues,
    }.toList()
      ..sort();
    return values;
  }

  List<String> get _provinces {
    final values = {
      ...provincesEducationnellesRdc.keys,
      ...widget.controller.provinces.map((e) => e.province),
      ...widget.controller.ecoles.map((e) => e.province),
    }
        .where((value) => value.isNotEmpty)
        .map(canonicalProvinceName)
        .toList()
      ..sort();
    return values;
  }

  Future<void> _openSchoolSearch() async {
    final school = await Navigator.of(context).push<GeoStat>(
      MaterialPageRoute(
        builder: (_) => SchoolSearchPage(
          controller: widget.controller,
          schools: widget.controller.ecoles,
          province: _province,
          provinceEducationnelle: _provinceEducationnelle,
        ),
      ),
    );
    if (school == null) {
      return;
    }
    setState(() {
      if (school.cleEcole.isEmpty) {
        _selectedSchool = null;
        return;
      }
      _selectedSchool = school;
      if (school.province.isNotEmpty) {
        _province = school.province;
      }
      if (school.provinceEducationnelle.isNotEmpty) {
        _provinceEducationnelle = school.provinceEducationnelle;
      }
    });
    widget.controller.clearEntityResults();
  }
}

class _ProvinceDropdown extends StatelessWidget {
  final String value;
  final List<String> provinces;
  final ValueChanged<String?> onChanged;

  const _ProvinceDropdown({
    Key? key,
    required this.value,
    required this.provinces,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = provinces.toSet().toList()..sort();
    final dropdownItems = [MinistreController.allLabel, ...items];
    return DropdownButtonFormField<String>(
      key: ValueKey('entity-province-$value-${items.length}'),
      initialValue:
          value.isEmpty || !dropdownItems.contains(value) ? 'Tout' : value,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Province',
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: dropdownItems
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _ProvinceEducationnelleDropdown extends StatelessWidget {
  final String value;
  final List<String> provinces;
  final ValueChanged<String?> onChanged;

  const _ProvinceEducationnelleDropdown({
    Key? key,
    required this.value,
    required this.provinces,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownItems = [MinistreController.allLabel, ...provinces];
    return DropdownButtonFormField<String>(
      key: ValueKey('entity-province-edu-$value-${provinces.length}'),
      initialValue:
          value.isEmpty || !dropdownItems.contains(value) ? 'Tout' : value,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Province educationnelle',
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: dropdownItems
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _SchoolSearchField extends StatelessWidget {
  final GeoStat? school;
  final VoidCallback onClear;
  final VoidCallback onTap;

  const _SchoolSearchField({
    Key? key,
    required this.school,
    required this.onClear,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = school;
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Ecole',
          border: const OutlineInputBorder(),
          isDense: true,
          suffixIcon: selected == null
              ? const Icon(Icons.search)
              : IconButton(
                  tooltip: 'Effacer',
                  icon: const Icon(Icons.close),
                  onPressed: onClear,
                ),
        ),
        child: Text(
          selected?.nomEcole.isNotEmpty == true
              ? selected!.nomEcole
              : 'Rechercher une ecole',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: selected == null ? const Color(0xFF607089) : null,
          ),
        ),
      ),
    );
  }
}

class SchoolSearchPage extends StatefulWidget {
  final MinistreController controller;
  final List<GeoStat> schools;
  final String province;
  final String provinceEducationnelle;

  const SchoolSearchPage({
    Key? key,
    required this.controller,
    required this.schools,
    required this.province,
    required this.provinceEducationnelle,
  }) : super(key: key);

  @override
  State<SchoolSearchPage> createState() => _SchoolSearchPageState();
}

class _SchoolSearchPageState extends State<SchoolSearchPage> {
  final TextEditingController _queryController = TextEditingController();
  List<GeoStat> _remoteSchools = <GeoStat>[];
  bool _loading = false;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadSchools();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schools = _filteredSchools;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(title: const Text('Choisir une ecole')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        children: [
          TextField(
            controller: _queryController,
            decoration: const InputDecoration(
              labelText: 'Nom ou identifiant de l ecole',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() => _query = value.trim());
              _loadSchools();
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFE3E8EF)),
            ),
            leading: const Icon(Icons.public, color: Color(0xFF2454A6)),
            title: const Text('Toutes les ecoles'),
            onTap: () => Navigator.of(context).pop(
              GeoStat(
                province: '',
                provinceEducationnelle: '',
                ville: '',
                cleEcole: '',
                nomEcole: '',
                totalSchools: 0,
                totalStudents: 0,
                totalTeachers: 0,
                totalAdminStaff: 0,
                successRate: 0,
                presenceRate: 0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (schools.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Aucune ecole trouvee',
                  style: TextStyle(color: Color(0xFF607089)),
                ),
              ),
            )
          else
            ...schools.map(
              (school) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    school.nomEcole,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    [
                      if (school.province.isNotEmpty) school.province,
                      if (school.provinceEducationnelle.isNotEmpty)
                        school.provinceEducationnelle,
                      if (school.ville.isNotEmpty) school.ville,
                    ].join(' / '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).pop(school),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<GeoStat> get _filteredSchools {
    final source = _remoteSchools.isEmpty ? widget.schools : _remoteSchools;
    final query = _query.toLowerCase();
    final schools = source.where((school) {
      final matchProvince = widget.province.isEmpty ||
          canonicalProvinceName(school.province) ==
              canonicalProvinceName(widget.province);
      final matchProvinceEducationnelle =
          widget.provinceEducationnelle.isEmpty ||
              school.provinceEducationnelle == widget.provinceEducationnelle;
      final matchQuery = query.isEmpty ||
          school.nomEcole.toLowerCase().contains(query) ||
          school.cleEcole.toLowerCase().contains(query);
      return school.cleEcole.isNotEmpty &&
          school.nomEcole.isNotEmpty &&
          matchProvince &&
          matchProvinceEducationnelle &&
          matchQuery;
    }).toList()
      ..sort((a, b) => a.nomEcole.compareTo(b.nomEcole));
    return schools;
  }

  Future<void> _loadSchools() async {
    setState(() => _loading = true);
    try {
      final schools = await widget.controller.searchSchools(
        search: _query,
        province: widget.province,
        provinceEducationnelle: widget.provinceEducationnelle,
        limit: 80,
      );
      if (!mounted) {
        return;
      }
      setState(() => _remoteSchools = schools);
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() => _remoteSchools = <GeoStat>[]);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }
}
