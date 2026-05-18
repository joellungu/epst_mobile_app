class BibliothequeCours {
  final int id;
  final String cours;
  final String propriete;
  final String banche;
  final String cycle;
  final int chapitre;
  final String notion;
  final int cls;
  final String type;
  final String idClasse;
  final String niveau;
  final String section;
  final String option;
  final String nomClasse;

  BibliothequeCours({
    required this.id,
    required this.cours,
    required this.propriete,
    required this.banche,
    required this.cycle,
    required this.chapitre,
    required this.notion,
    required this.cls,
    required this.type,
    required this.idClasse,
    required this.niveau,
    required this.section,
    required this.option,
    required this.nomClasse,
  });

  factory BibliothequeCours.fromJson(Map<String, dynamic> json) {
    return BibliothequeCours(
      id: _asInt(json['id']),
      cours: _clean(json['cours']),
      propriete: _clean(json['propriete']),
      banche: _clean(json['banche']),
      cycle: _clean(json['cycle']),
      chapitre: _asInt(json['chapitre']),
      notion: _clean(json['notion']),
      cls: _asInt(json['cls']),
      type: _clean(json['type']).toLowerCase(),
      idClasse: _clean(json['idClasse']),
      niveau: _clean(json['niveau']),
      section: _clean(json['section']),
      option: _clean(json['option']),
      nomClasse: _clean(json['nomClasse']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cours': cours,
      'propriete': propriete,
      'banche': banche,
      'cycle': cycle,
      'chapitre': chapitre,
      'notion': notion,
      'cls': cls,
      'type': type,
      'idClasse': idClasse,
      'niveau': niveau,
      'section': section,
      'option': option,
      'nomClasse': nomClasse,
    };
  }

  String get titre {
    if (cours.isNotEmpty) {
      return cours;
    }
    if (banche.isNotEmpty) {
      return banche;
    }
    return 'Cours $id';
  }

  String get detail {
    final items = [banche, notion, cycle].where((e) => e.isNotEmpty).toList();
    return items.join(' - ');
  }

  String get extension => type.isEmpty ? 'bin' : type.replaceAll('.', '');

  bool get isZip => extension.toLowerCase() == 'zip';

  static String _clean(dynamic value) {
    final text = '${value ?? ''}'.trim();
    return text == 'null' ? '' : text;
  }

  static int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse('${value ?? 0}') ?? 0;
  }
}
