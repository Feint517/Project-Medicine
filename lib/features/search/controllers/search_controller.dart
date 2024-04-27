import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/data/medication/drug_model.dart';
import 'package:project_med/data/services/database_service.dart';

class DrugSearchController extends GetxController {
  static DrugSearchController get instance => Get.find();
  final database = Get.put(DatabaseService());

  final searchedDrug = TextEditingController();
  List<DrugModel>? searchResult;

  // @override
  // void onInit() {
  //   searchResult = database.fetchAll();
  //   super.onInit();
  // }

  searchDrug(name) async{
    searchResult =  await database.fetchByName(name);
  }
}
