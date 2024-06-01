import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/data/services/database_service.dart';

class DrugSearchController extends GetxController {
  static DrugSearchController get instance => Get.find();
  final database = Get.put(DatabaseService());

  final tableName = 'interactions';
  final searchedDrug1 = TextEditingController();
  final searchedDrug2 = TextEditingController();
  RxBool searched = false.obs;
  final searchResult = [].obs;

  searchInteraction() async {
    searchResult.clear();
    final name1 = searchedDrug1.text;
    final name2 = searchedDrug2.text;
    searched.value = true;
    final result = await database.fetchByName(
      drug1: name1,
      drug2: name2,
      table: tableName,
    );
    for (var i = 0; i < result.length; i++) {
      searchResult.add(result[i]);
    }
  }
}
