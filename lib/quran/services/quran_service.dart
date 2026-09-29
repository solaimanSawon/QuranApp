import 'dart:convert';

import 'package:http/http.dart' as http;

class QuranService {
  static const String baseUrl = 'https://api.quran.com/api/v4';

  // ১. সব সূরার তালিকা আনার জন্য
  static Future<List<dynamic>> fetchSurahList() async {
    final response = await http.get(Uri.parse('$baseUrl/chapters?language=bn'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['chapters'];
    } else {
      throw Exception('Failed to load Surah list');
    }
  }

  // ২. নির্দিষ্ট সূরার আরবি আয়াত ও বাংলা অনুবাদ আনার জন্য
  // translation ID 161 = মহিউদ্দিন খান (বাংলা)
  static Future<List<dynamic>> fetchSurahDetails(int surahId) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/verses/by_chapter/$surahId?language=bn&translations=161&fields=text_uthmani&per_page=300',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['verses'];
    } else {
      throw Exception('Failed to load Ayahs');
    }
  }
}
