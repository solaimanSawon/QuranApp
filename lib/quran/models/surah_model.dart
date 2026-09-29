class Surah {
  final int id;
  final String nameSimple;
  final String nameArabic;
  final String translatedName;
  final int versesCount;

  Surah({
    required this.id,
    required this.nameSimple,
    required this.nameArabic,
    required this.translatedName,
    required this.versesCount,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'],
      nameSimple: json['name_simple'],
      nameArabic: json['name_arabic'],
      translatedName: json['translated_name']['name'],
      versesCount: json['verses_count'],
    );
  }
}
