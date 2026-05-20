class BibliothequeClasse {
  final String id;
  final String nom;
  final String cycle;
  final String niveau;
  final String section;
  final String option;
  final int totalCours;

  BibliothequeClasse({
    required this.id,
    required this.nom,
    required this.cycle,
    required this.niveau,
    required this.section,
    required this.option,
    required this.totalCours,
  });

  factory BibliothequeClasse.fromCourses(List<Map<String, dynamic>> courses) {
    final first = courses.first;
    final name = _firstNotEmpty([
      first['nomClasse'],
      first['niveau'],
      first['classe'],
      _clean(first['cls']).isEmpty ? '' : '${_clean(first['cls'])}e',
    ]);

    return BibliothequeClasse(
      id: '${first['idClasse'] ?? ''}',
      nom: name.isEmpty ? 'Classe' : name,
      cycle: _clean(first['cycle']),
      niveau: _clean(first['niveau']),
      section: _clean(first['section']),
      option: _clean(first['option']),
      totalCours: courses.length,
    );
  }

  factory BibliothequeClasse.fromJson(
    Map<String, dynamic> json, {
    int totalCours = 0,
  }) {
    final labelParts = [
      json['niveau'],
      json['cycle'],
      _firstNotEmpty([json['option'], json['section']]),
      json['nom'],
    ].map(_clean).where((value) => value.isNotEmpty).toList();
    final name = _firstNotEmpty([
      json['nomClasse'],
      labelParts.join(' '),
      json['classe'],
      json['niveau'],
    ]);

    return BibliothequeClasse(
      id: _firstNotEmpty([json['id'], json['idClasse'], json['cle']]),
      nom: name.isEmpty ? 'Classe' : name,
      cycle: _clean(json['cycle']),
      niveau: _clean(json['niveau']),
      section: _clean(json['section']),
      option: _clean(json['option']),
      totalCours: totalCours,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'cycle': cycle,
      'niveau': niveau,
      'section': section,
      'option': option,
      'totalCours': totalCours,
    };
  }

  BibliothequeClasse copyWith({int? totalCours}) {
    return BibliothequeClasse(
      id: id,
      nom: nom,
      cycle: cycle,
      niveau: niveau,
      section: section,
      option: option,
      totalCours: totalCours ?? this.totalCours,
    );
  }

  String get shortLabel {
    final value = _firstNotEmpty([niveau, nom]);
    if (value.isEmpty) {
      return '-';
    }
    return value.length > 4 ? value.substring(0, 4) : value;
  }

  static String _clean(dynamic value) {
    final text = '${value ?? ''}'.trim();
    return text == 'null' ? '' : text;
  }

  static String _firstNotEmpty(List<dynamic> values) {
    for (final value in values) {
      final text = _clean(value);
      if (text.isNotEmpty) {
        return text;
      }
    }
    return '';
  }
}
