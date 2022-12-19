// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kelompok1_flutter/app/data/models/detail_surah.dart';
import 'package:kelompok1_flutter/app/data/models/juz.dart';
import 'package:kelompok1_flutter/app/data/models/surah.dart';

Future<List<Map<String, dynamic>>> main() async {
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
          print("============");
          print("BERHASIL MEMASUKAN JUZ $juz");
          print("START :");
          print("Ayat: ${(penampungAyat[0]['ayat'] as Verse).number?.inSurah}");
          print((penampungAyat[0]["ayat"] as Verse).text?.arab);
          print("END :");
          print(
              "Ayat: ${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).number?.inSurah}");
          print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
              .text
              ?.arab);
          allJuz.add({
            "juz": juz,
            "juzStartInfo": penampungAyat[0],
            "juzEndInfo": penampungAyat[penampungAyat.length - 1],
            "verses": penampungAyat,
          });
          juz++;
          penampungAyat.clear();
          penampungAyat.add({
            "surah": data.name?.transliteration?.id ?? '',
            "ayat": ayat,
          });
        }
      });
    }
  }

  print("============");
  print("BERHASIL MEMASUKAN JUZ $juz");
  print("START :");
  print("Ayat: ${(penampungAyat[0]['ayat'] as Verse).number?.inSurah}");
  print((penampungAyat[0]["ayat"] as Verse).text?.arab);
  print("END :");
  print(
      "Ayat: ${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).number?.inSurah}");
  print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse).text?.arab);
  allJuz.add({
    "juz": juz,
    "juzStartInfo": penampungAyat[0],
    "juzEndInfo": penampungAyat[penampungAyat.length - 1],
    "verses": penampungAyat,
  });
  return allJuz;
}
