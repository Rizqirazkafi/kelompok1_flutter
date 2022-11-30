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

Future<List<Juz>> main() async {
  List<Juz> allJuz = [];
  for (int i = 1; i <= 30; i++) {
    Uri url = Uri.parse("https://api-quran-weld.vercel.app/juz/$i");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    Juz juz = Juz.fromJson(data);
    allJuz.add(juz);
    Map<String, dynamic> dataToModel = {
      "juz": data["juz"],
      //"juzStartSurahNumber": data["juzEndSurahNumber"],
      "juzStartInfo": data["juzStartInfo"],
      "juzEndInfo": data["juzEndInfo"],
      "totalVerses": data["totalVerses"],
    };
    print(dataToModel);
  }

  return allJuz;

  // return allJuz;
  // Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  // var res = await http.get(url);

  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  // // 1-114 -> index ke 113 [An-Nas]
  // // print(data[113]["number"]);
  // // Data dari API(raw data) -> Model (Yang sudh disiapin)
  // Surah surahAnnas = Surah.fromJson(data[113]);
  // // print(surahAnnas.name);
  // // print("==========");
  // // print(surahAnnas.number);
  // // print("==========");
  // // print(surahAnnas.numberOfVerses);
  // // print("==========");
  // // print(surahAnnas.tafsir);
  // // print(surahAnnas.number);
  // Uri urlAnnas =
  //     Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  // var resAnnas = await http.get(urlAnnas);
  // Map<String, dynamic> dataAnnas =
  //     (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];
  // // Data dari API(raw data) -> Model (Yang sudh disiapin)
  // Detailsurah annas = Detailsurah.fromJson(dataAnnas);

  // Surah surahAnnas = Surah.fromJson(data[113]);
}
