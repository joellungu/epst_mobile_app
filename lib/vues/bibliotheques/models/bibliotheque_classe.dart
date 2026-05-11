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
