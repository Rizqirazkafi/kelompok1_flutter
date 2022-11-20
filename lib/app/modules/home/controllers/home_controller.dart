import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'package:kelompok1_flutter/app/data/models/surah.dart';

// import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
    // Surah surahAnnas = Surah.fromJson(data[113]);
=======

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
>>>>>>> e863ad39ca0094fbddd2f66d0ebfe9e9f46efab8
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
