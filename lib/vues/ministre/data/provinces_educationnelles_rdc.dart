const Map<String, List<String>> provincesEducationnellesRdc = {
  'Kinshasa': [
    'Kinshasa Funa',
    'Kinshasa Lukunga',
    'Kinshasa Mont-Amba',
    'Kinshasa Plateau',
    'Kinshasa Tshangu',
  ],
  'Kongo Central': [
    'Kongo Central 1',
    'Kongo Central 2',
    'Kongo Central 3',
  ],
  'Kwango': ['Kwango 1', 'Kwango 2'],
  'Kwilu': ['Kwilu 1', 'Kwilu 2', 'Kwilu 3'],
  'Mai-Ndombe': ['Mai-Ndombe 1', 'Mai-Ndombe 2', 'Mai-Ndombe 3'],
  'Équateur': ['Équateur 1', 'Équateur 2'],
  'Tshuapa': ['Tshuapa 1', 'Tshuapa 2'],
  'Mongala': ['Mongala 1', 'Mongala 2'],
  'Nord-Ubangi': ['Nord-Ubangi 1', 'Nord-Ubangi 2'],
  'Sud-Ubangi': ['Sud-Ubangi 1', 'Sud-Ubangi 2'],
  'Bas-Uélé': ['Bas-Uélé'],
  'Haut-Uélé': ['Haut-Uélé 1', 'Haut-Uélé 2'],
  'Ituri': ['Ituri 1', 'Ituri 2', 'Ituri 3'],
  'Tshopo': ['Tshopo 1', 'Tshopo 2'],
  'Maniema': ['Maniema 1', 'Maniema 2'],
  'Nord-Kivu': ['Nord-Kivu 1', 'Nord-Kivu 2', 'Nord-Kivu 3'],
  'Sud-Kivu': ['Sud-Kivu 1', 'Sud-Kivu 2', 'Sud-Kivu 3'],
  'Tanganyika': ['Tanganyika 1', 'Tanganyika 2'],
  'Haut-Lomami': ['Haut-Lomami 1', 'Haut-Lomami 2'],
  'Lualaba': ['Lualaba 1', 'Lualaba 2'],
  'Haut-Katanga': ['Haut-Katanga 1', 'Haut-Katanga 2'],
  'Lomami': ['Lomami 1', 'Lomami 2'],
  'Sankuru': ['Sankuru 1', 'Sankuru 2'],
  'Kasaï Oriental': ['Kasaï Oriental 1', 'Kasaï Oriental 2'],
  'Kasaï Central': ['Kasaï Central 1', 'Kasaï Central 2'],
  'Kasaï': ['Kasaï 1', 'Kasaï 2'],
};

String normalizeProvinceKey(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll('é', 'e')
      .replaceAll('è', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('ë', 'e')
      .replaceAll('à', 'a')
      .replaceAll('â', 'a')
      .replaceAll('ä', 'a')
      .replaceAll('î', 'i')
      .replaceAll('ï', 'i')
      .replaceAll('ô', 'o')
      .replaceAll('ö', 'o')
      .replaceAll('ù', 'u')
      .replaceAll('û', 'u')
      .replaceAll('ü', 'u')
      .replaceAll('ç', 'c');
}

String canonicalProvinceName(String value) {
  final normalized = normalizeProvinceKey(value);
  for (final province in provincesEducationnellesRdc.keys) {
    if (normalizeProvinceKey(province) == normalized) {
      return province;
    }
  }
  return value.trim();
}

List<String> provincesEducationnellesForProvince(String province) {
  final canonical = canonicalProvinceName(province);
  return provincesEducationnellesRdc[canonical] ?? const [];
}
