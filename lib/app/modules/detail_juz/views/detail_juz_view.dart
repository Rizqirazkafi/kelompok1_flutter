// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelompok1_flutter/app/data/models/detail_surah.dart' as detail;

import '../../../contents/color.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JUZ ${dataMapPerJuz['juz']}"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: (dataMapPerJuz["verses"] as List).length,
        itemBuilder: (context, index) {
          if ((dataMapPerJuz["verses"] as List).length == 0) {
            // ignore: prefer_const_constructors
            return Center(
              child: Text("Tidak ada data"),
            );
          }
          Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if ((ayat["ayat"] as detail.Verse).number?.inSurah == 1)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      // onTap: () => Get.dialog(
                      //   Dialog(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30)),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(30),
                      //           color: appPurpleLight2.withOpacity(0.2)),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(15),
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             SizedBox(
                      //               height: 20,
                      //             ),
                      //             Text(
                      //               "TAFSIR",
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 20,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 20,
                      //             ),
                      //             Text(
                      //                 "${surah.tafsir?.id ?? "Tidak Ada Tafsir pada surah ini..."}",
                      //                 textAlign: TextAlign.justify),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [appPurpleLight1, appPurpleDark]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "${ayat["surah"]}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: appWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: appPurpleLight2.withOpacity(0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/image/list.png"))),
                            child: Center(
                              child: Text(
                                  "${(ayat['ayat'] as detail.Verse).number?.inSurah}"),
                            ),
                          ),
                          Text(" ")
                        ],
                      ),
                      Text(
                        "${ayat['surah']}",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.bookmark_added_outlined),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${(ayat['ayat'] as detail.Verse).text?.arab}",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              Text(
                "${(ayat['ayat'] as detail.Verse).text?.transliteration?.en}",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 5),
              Text(
                "${(ayat['ayat'] as detail.Verse).translation?.id}",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
