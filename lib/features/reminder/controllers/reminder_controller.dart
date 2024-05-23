import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:project_med/data/services/database_service.dart';
import 'package:project_med/navigation_menu.dart';

class ReminderController extends GetxController {
  static ReminderController get instance => Get.find();
  final database = Get.put(DatabaseService());

  //* variables
  final tableName = 'treatments';
  final medicationName = TextEditingController();
  final medicationDose = TextEditingController(
      text: '0'); //? default value in case it's not specified
  final medicationFrequency = TextEditingController(text: '');
  GlobalKey<FormState> frequencyFormKey = GlobalKey<FormState>();
  RxList<bool> booleanTypeList = [false, false, false, false, false].obs;
  RxList<bool> booleanTimingList =
      [false, false, false, false, false, false].obs;
  String selectedMedType = '';
  RxInt selectedMedIndex = 10.obs;
  String selectedMedTiming = '';
  String selectedInjectionSite = '';
  RxList<bool> booleanInjectSiteList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;
  int selectedDateInt = 0;
  var finalList = [].obs;
  //* =========================//*
  dynamic formattedHour = ''.obs;
  //*============================//*
  RxList<TreatmentModel> treatmentsList = <TreatmentModel>[].obs;
  //*============================//*

  //* methods
  Future<int> assignId() async {
    int id;
    if ((await database.getCount(table: tableName)) == null) {
      id = 1;
    } else {
      id = (await database.getCount(table: tableName))! + 1;
    }
    return id;
  }

  void selectMedType(index) {
    booleanTypeList.setAll(0, [false, false, false, false, false]);
    booleanTypeList[index] = !booleanTypeList[index];
    switch (index) {
      case 0:
        {
          selectedMedType = 'Pill';
          selectedMedIndex.value = 0;
        }
      case 1:
        {
          selectedMedType = 'Eye Drop';
          selectedMedIndex.value = 1;
        }
      case 2:
        {
          selectedMedType = 'Liquid';
          selectedMedIndex.value = 2;
        }
      case 3:
        {
          selectedMedType = 'injection';
          selectedMedIndex.value = 3;
        }
      case 4:
        {
          selectedMedType = 'inhaler';
          selectedMedIndex.value = 4;
        }
    }
    if (kDebugMode) {
      print('$selectedMedType is selected');
      print('index = $selectedMedIndex');
    }
  }

  void selectMedTiming(index) {
    booleanTimingList.setAll(0, [false, false, false, false, false]);
    booleanTimingList[index] = !booleanTimingList[index];
    switch (index) {
      case 0:
        {
          selectedMedTiming = 'Before eat';
        }

      case 1:
        {
          selectedMedTiming = 'After eat';
        }

      case 2:
        {
          selectedMedTiming = 'With food';
        }

      case 3:
        {
          selectedMedTiming = 'Before sleep';
        }
    }
    if (kDebugMode) {
      print('$selectedMedTiming is selected');
    }
  }

  void selectInjectionSite(index) {
    booleanInjectSiteList.setAll(0,
        [false, false, false, false, false, false, false, false, false, false]);
    booleanInjectSiteList[index] = !booleanInjectSiteList[index];

    switch (index) {
      case 0:
        {
          selectedInjectionSite = 'Upper arm';
        }

      case 1:
        {
          selectedInjectionSite = 'Thigh';
        }

      case 2:
        {
          selectedInjectionSite = 'Buttocks';
        }

      case 3:
        {
          selectedInjectionSite = 'Hip';
        }

      case 4:
        {
          selectedInjectionSite = 'Abdomen';
        }

      case 5:
        {
          selectedInjectionSite = 'Upper arm';
        }

      case 6:
        {
          selectedInjectionSite = 'Forearm';
        }

      case 7:
        {
          selectedInjectionSite = 'Back of the hands';
        }

      case 8:
        {
          selectedInjectionSite = 'Front and back of the lower arm';
        }

      case 9:
        {
          selectedInjectionSite = 'Front elbow pit';
        }
    }
    if (kDebugMode) {
      print('selected injecting site = $selectedInjectionSite');
    }
  }

  void selectDate(value) {
    //? the user should always select a date
    if (value == null) {
      CustomLoaders.warningSnackBar(title: 'Please select a date');
      return;
    }
    if (kDebugMode) {
      print('===========================');
      print('value = $value');
      print('value runtime type = ${value.runtimeType}');
      print('===========================');
    }
    DateTime selectedDate = value;
    selectedDateInt = selectedDate.millisecondsSinceEpoch;
    if (kDebugMode) {
      print('selectedDateInt runtime type = ');
      print(selectedDateInt.runtimeType);
      print(selectedDateInt);
    }
    Get.back();
  }

  void selectHour(time) {
    formattedHour.value = DateFormat.Hm().format(time);
  }

  void saveMedication() async {
    if (kDebugMode) {
      print('===========================');
      print('Treatment info:');
      print('id = $assignId()');
      print('type: $selectedMedType');
      print('name: ${medicationName.text}');
      print('dose: ${medicationDose.text}');
      print('frequency: ${medicationFrequency.text}');
      print('timing: $selectedMedTiming');
      print('injeting site: $selectedInjectionSite');
      print('date: $selectedDateInt');
      print('hour: $formattedHour');
      print('===========================');
    }
    var myInt = int.parse(medicationDose.text);
    database.add(
      object: TreatmentModel(
        id: await assignId(),
        type: selectedMedType,
        name: medicationName.text,
        dose: myInt,
        frequency: medicationFrequency.text,
        timing: selectedMedTiming.toLowerCase(),
        date: selectedDateInt,
        hour: formattedHour.value,
      ),
      table: tableName,
    );
  }

  void deleteTreatment({required int id}) async {
    database.delete(table: tableName, id: id);
  }

  void fetchTreatmentsByDate({required int convertedDate}) async {
    treatmentsList.clear();
    final result = await database.fetchTreatmentsFromDate(
      table: tableName,
      convertedDate: convertedDate,
    );
    if (kDebugMode) {
      print('=======================================');
      print('result length = ${result.length}');
      print('resilt = $result');
    }
    for (var i = 0; i < result.length; i++) {
      treatmentsList.add(result[i]);
    }
    if (kDebugMode) {
      print('=======================================');
      print(treatmentsList);
    }
  }

  void validateAndSaveEnteries() {
    switch (selectedMedIndex.value) {
      case 0:
        {
          if (medicationName.text.isEmpty ||
              medicationDose.text.isEmpty ||
              medicationFrequency.text.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return;
          }
        }
      case 1:
        {
          if (medicationName.text.isEmpty || medicationFrequency.text.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return;
          }
        }
      case 2:
        {
          if (medicationName.text.isEmpty || medicationDose.text.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return;
          }
        }
      case 3:
        {
          if (medicationName.text.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return;
          }
        }
      case 4:
        {
          if (medicationName.text.isEmpty || medicationFrequency.text.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return;
          }
        }
    }

    saveMedication();
    Get.off(() => const NavigationMenu());
    clearEverything();
  }

  void clearEverything() {
    booleanTypeList.setAll(0, [false, false, false, false, false]);
    medicationName.clear();
    medicationDose.clear();
    medicationFrequency.clear();
    booleanTimingList.setAll(0, [false, false, false, false, false]);
    selectedMedIndex.value = 10;
  }

  //   //* Custom validation: Check if the input follows the format "X times a day"
  //   final RegExp frequencyPattern =
  //       RegExp(r'^\d+\s+times\s+a\s+day$', caseSensitive: false);
  //   if (!frequencyPattern.hasMatch(value)) {
  //     return 'Invalid format. Enter like "3 times a day"';
  //   }
  //   return null; //? Return null if input is valid.
  // }
}
