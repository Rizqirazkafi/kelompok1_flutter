// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_quran/app/data/models/detail_surah.dart';
import 'package:my_quran/app/data/models/surah.dart';

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res = await http.get(url);

  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  // 1-114 -> index ke 113 [An-Nas]
  // print(data[113]["number"]);
  // Data dari API(raw data) -> Model (Yang sudh disiapin)
  Surah surahAnnas = Surah.fromJson(data[113]);
  // print(surahAnnas.name);
  // print("==========");
  // print(surahAnnas.number);
  // print("==========");
  // print(surahAnnas.numberOfVerses);
  // print("==========");
  // print(surahAnnas.tafsir);
  // print(surahAnnas.number);
  Uri urlAnnas =
      Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var resAnnas = await http.get(urlAnnas);
  Map<String, dynamic> dataAnnas =
      (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];
  // Data dari API(raw data) -> Model (Yang sudh disiapin)
  DetailSurah annas = DetailSurah.fromJson(dataAnnas);
  print(annas.verses![0].text!.arab);
}
