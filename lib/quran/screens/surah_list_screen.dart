import 'package:flutter/material.dart';

import '../services/quran_service.dart';
import 'surah_detail_screen.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Al-Quran')),
      body: FutureBuilder<List<dynamic>>(
        future: QuranService.fetchSurahList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Kono surah pawa jayni.'));
          }

          final surahs = snapshot.data!;
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${surah['id']}')),
                title: Text(
                  '${surah['name_simple']} (${surah['translated_name']['name']})',
                ),
                subtitle: Text(
                  'Ayah: ${surah['verses_count']} | ${surah['revelation_place']}',
                ),
                trailing: Text(
                  surah['name_arabic'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahDetailScreen(
                        surahId: surah['id'],
                        surahName: surah['name_simple'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
