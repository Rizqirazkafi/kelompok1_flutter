// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelompok1_flutter/app/contents/color.dart';
import 'package:kelompok1_flutter/app/data/models/juz.dart' as juz;
import 'package:kelompok1_flutter/app/data/models/surah.dart';
import 'package:kelompok1_flutter/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Al - Quran Apps'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assalamuallaikum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [appPurpleLight1, appPurpleDark])),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -45,
                              right: 0,
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Image.asset("assets/image/quran.png"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: appWhite,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        "Terakhir dibaca",
                                        style: TextStyle(color: appWhite),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "Al - Fatihah",
                                    style: TextStyle(color: appWhite),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Ayat",
                                    style: TextStyle(color: appWhite),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TabBar(
                  tabs: [
                    Tab(
                      text: "Surah",
                    ),
                    Tab(
                      text: "Juz",
                    ),
                    Tab(
                      text: "Bookmark",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder<List<Surah>>(
                          future: controller.getAllSurah(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text("Tidak Ada Data"),
                              );
                            }
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Surah surah = snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_SURAH,
                                        arguments: surah);
                                  },
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/image/list.png"))),
                                    child: Center(
                                      child: Text("${surah.number}"),
                                    ),
                                  ),
                                  title: Text(
                                      "${surah.name?.transliteration?.id ?? 'Error..'}"),
                                  subtitle: Text(
                                      "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'} "),
                                  trailing:
                                      Text("${surah.name?.short ?? 'Error..'}"),
                                );
                              },
                            );
                          }),
                      FutureBuilder<List<juz.Juz>>(
                        future: controller.getAllJuz(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text("Tidak Ada Data"),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                juz.Juz detailJuz = snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_JUZ,
                                        arguments: detailJuz);
                                  },
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/image/list.png"))),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                      ),
                                    ),
                                  ),
                                  title: Text("Juz ${index + 1}"),
                                  isThreeLine: true,
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Dimulai dari ${detailJuz.juzStartInfo}"),
                                      Text("Sampai ${detailJuz.juzEndInfo}")
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      Center(child: Text("data")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.isDarkMode
                ? Get.changeTheme(themeLight)
                : Get.changeTheme(themeDark);
            controller.isDark.toggle();
          },
          child: Obx(
            () => Icon(
              Icons.color_lens,
              color: controller.isDark.isTrue ? appPurpleDark : appWhite,
            ),
          ),
        ));
  }
}
