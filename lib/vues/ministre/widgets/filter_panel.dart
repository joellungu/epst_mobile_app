import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';

class MinistreFilterPanel extends StatelessWidget {
  final MinistreController controller;

  const MinistreFilterPanel({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tune, color: Color(0xFF2454A6)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Filtres geographiques',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: controller.clearFilters,
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Effacer'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _FilterDropdown(
            label: 'Province',
            value: controller.selectedProvince.value,
            items: controller.provinces
                .map((e) => e.province)
                .where((e) => e.isNotEmpty)
                .toSet()
                .toList(),
            onChanged: (value) => controller.applyProvince(value ?? ''),
            allLabel: MinistreController.allLabel,
          ),
          const SizedBox(height: 8),
          _FilterDropdown(
            label: 'Ville',
            value: controller.selectedVille.value,
            items: controller.villes
                .map((e) => e.ville)
                .where((e) => e.isNotEmpty)
                .toSet()
                .toList(),
            onChanged: (value) => controller.applyVille(value ?? ''),
            allLabel: MinistreController.allLabel,
          ),
          const SizedBox(height: 8),
          _SchoolDropdown(controller: controller),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String allLabel;

  const _FilterDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.allLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cleanItems = items.toSet().toList()..sort();
    final dropdownItems = [allLabel, ...cleanItems];
    return DropdownButtonFormField<String>(
      key: ValueKey('$label-$value-${dropdownItems.length}'),
      isExpanded: true,
      initialValue:
          value.isEmpty || !dropdownItems.contains(value) ? allLabel : value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      items: dropdownItems
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _SchoolDropdown extends StatelessWidget {
  final MinistreController controller;

  const _SchoolDropdown({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schools = controller.ecoles
        .where((e) => e.cleEcole.isNotEmpty && e.nomEcole.isNotEmpty)
        .toList()
      ..sort((a, b) => a.nomEcole.compareTo(b.nomEcole));
    const allSchoolValue = '__all__';
    final schoolItems = <DropdownMenuItem<String>>[
      const DropdownMenuItem<String>(
        value: allSchoolValue,
        child: Text(MinistreController.allLabel),
      ),
      ...schools.map(
        (school) => DropdownMenuItem<String>(
          value: school.cleEcole,
          child: Text(
            school.nomEcole,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
    return DropdownButtonFormField<String>(
      key: ValueKey(
          'school-${controller.selectedCleEcole.value}-${schools.length}'),
      isExpanded: true,
      initialValue: controller.selectedCleEcole.value.isEmpty ||
              !schools
                  .any((e) => e.cleEcole == controller.selectedCleEcole.value)
          ? allSchoolValue
          : controller.selectedCleEcole.value,
      decoration: const InputDecoration(
        labelText: 'Ecole',
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: schoolItems,
      onChanged: (value) {
        if (value == allSchoolValue) {
          controller.applyEcole(
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
          );
          return;
        }
        GeoStat? school;
        for (final item in schools) {
          if (item.cleEcole == value) {
            school = item;
            break;
          }
        }
        if (school != null) {
          controller.applyEcole(school);
        }
      },
    );
  }
}
