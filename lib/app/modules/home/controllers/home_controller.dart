import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelompok1_flutter/app/data/models/detail_surah.dart';
import 'package:kelompok1_flutter/app/data/models/surah.dart';

// import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  RxBool isDark = false.obs;
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api-quran-weld.vercel.app/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    // ignore: unnecessary_null_comparison
    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
    // Surah surahAnnas = Surah.fromJson(data[113]);
  }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;
    List<Map<String, dynamic>> penampungAyat = [];
    List<Map<String, dynamic>> allJuz = [];
    for (var i = 1; i <= 144; i++) {
      var res =
          await http.get(Uri.parse("https://api-quran-weld.vercel.app/juz/$i"));
      Map<String, dynamic> rawData = json.decode(res.body)["data"];
      Detailsurah data = Detailsurah.fromJson(rawData);

      if (data.verses != null) {
        data.verses!.forEach((ayat) {
          if (ayat.meta?.juz == juz) {
            penampungAyat.add({
              "surah": data.name?.transliteration?.id ?? '',
              "ayat": ayat,
            });
          } else {
            allJuz.add({
              "juz": juz,
              "juzStartInfo": penampungAyat[0],
              "juzEndInfo": penampungAyat[penampungAyat.length - 1],
              "verses": penampungAyat,
            });
            juz++;
            penampungAyat = [];
            penampungAyat.add({
              "surah": data.name?.transliteration?.id ?? '',
              "ayat": ayat,
            });
          }
        });
      }
    }
    allJuz.add({
      "juz": juz,
      "juzStartInfo": penampungAyat[0],
      "juzEndInfo": penampungAyat[penampungAyat.length - 1],
      "verses": penampungAyat,
    });
    return allJuz;
  }
}
