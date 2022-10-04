import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getAllSurah(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text("Surah Al - ..."),
                subtitle: Text("7 Ayat | Makiyyah"),
                trailing: Text("tulisan arab"),
              ),
            );
          }),
    );
  }
}
