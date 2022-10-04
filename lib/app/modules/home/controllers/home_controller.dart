import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    print(data);
    // Surah surahAnnas = Surah.fromJson(data[113]);
  }
}
