import 'dart:convert';

import 'package:get/get.dart';
import 'package:kelompok1_flutter/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  Future<Detailsurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api-quran-weld.vercel.app/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return Detailsurah.fromJson(data);
  }
}
