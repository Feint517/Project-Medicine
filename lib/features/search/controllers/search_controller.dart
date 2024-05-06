import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/data/services/database_service.dart';

class DrugSearchController extends GetxController {
  static DrugSearchController get instance => Get.find();
  final database = Get.put(DatabaseService());

  final tableName = 'drugs';
  final tableName2 = 'interactions';
  final searchedDrug = TextEditingController();
  final searchResult = [].obs;

  // searchAll() async {
  //   final result = await database.fetchAll(table: tableName);
  //   for (var i = 0; i < result.length; i++) {
  //     searchResult.add(result[i]);
  //   }
  // }

  // searchDrug() async {
  //   searchResult.clear();
  //   final name = searchedDrug.text;
  //   //final name2 = searchedDrug2.text;
  //   final result = await database.fetchByName(name: name, table: tableName);
  //   for (var i = 0; i < result.length; i++) {
  //     searchResult.add(result[i]);
  //   }
  // }

  searchInteraction() async {
    searchResult.clear();
    final name = searchedDrug.text;
    final result = await database.fetchByName(name: name, table: tableName2);
    for (var i = 0; i < result.length; i++) {
      searchResult.add(result[i]);
    }
  }
}
