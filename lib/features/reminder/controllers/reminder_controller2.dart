import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:project_med/data/services/database_service.dart';

class ReminderController2 extends GetxController {
  static ReminderController2 get instance => Get.find();
  final database = Get.put(DatabaseService());

  //* variables
  final tableName = 'treatments';
  final medicationName = TextEditingController();
  final medicationDose = TextEditingController(
      text: ''); //? defualt value in case it's not specified
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
//* =========================//*
  List<DateTime> selectedDates = [];
  //dynamic selectedDates;
  //List<String> formatedDates = [];
  List<int> selectedDatesInt = [];
  var finalList = [].obs;
  //* =========================//*
  dynamic formattedHour = ''.obs;
  //*============================//*
  RxList<TreatmentModel> treatmentsList = <TreatmentModel>[].obs;

  //* methods

  void fetchtreatments() async {
    final result = await database.fetchAllTreatment(table: tableName);
    for (var i = 0; i < result.length; i++) {
      treatmentsList.add(result[i]);
    }
  }

  saveMedication() {
    final medicationDoseInt = int.parse(medicationDose.text);
    database.saveToDatabase(
      table: tableName,
      type: selectedMedType,
      name: medicationName.text,
      dose: medicationDoseInt,
      frequency: medicationFrequency.text,
      timing: selectedMedTiming,
      date: selectedDatesInt.join(','),
      hour: formattedHour.value,
    );
  }

  void selectDate(value) {
    selectedDatesInt.clear();
    //? the user should alawys select a date
    if (value == null) {
      CustomLoaders.warningSnackBar(title: 'Please select a date');
      return;
    }
    if (kDebugMode) {
      print('value = $value');
      print('value runtime type = ');
      print(value.runtimeType);
    }
    selectedDates = value;
    for (int i = 0; i < selectedDates.length; i++) {
      // formatedDates.add(DateFormat('yyyy-MM-dd').format(selectedDates[i]));
      // if (kDebugMode) {
      //   print('selectedDates[$i]');
      //   print(selectedDates[i]);
      // }
      // finalList.add(formatedDates[i]);
      selectedDatesInt.add(selectedDates[i].millisecondsSinceEpoch);
    }
    if (kDebugMode) {
      print('selectedDatesInt runtime type = ');
      print(selectedDatesInt.runtimeType);
      print(selectedDatesInt);
    }
    Get.back();
  }

  void selectHour(time) {
    formattedHour.value = DateFormat.Hm().format(time);
    //print(formattedHour);
  }

  void selectMedType(index) {
    booleanTypeList.setAll(0, [false, false, false, false, false]);
    booleanTypeList[index] = !booleanTypeList[index];
    switch (index) {
      case 0:
        {
          print('pill is selected');
          selectedMedType = 'Pill';
          selectedMedIndex.value = 0;
          print('index = $selectedMedIndex');
        }
      case 1:
        {
          print('Eye Drop is selected');
          selectedMedType = 'Eye Drop';
          selectedMedIndex.value = 1;
          print('index = $selectedMedIndex');
        }
      case 2:
        {
          print('Liquid is selected');
          selectedMedType = 'Liquid';
          selectedMedIndex.value = 2;
          print('index = $selectedMedIndex');
        }
      case 3:
        {
          print('injection is selected');
          selectedMedType = 'injection';
          selectedMedIndex.value = 3;
          print('index = $selectedMedIndex');
        }
      case 4:
        {
          print('inhaler is selected');
          selectedMedType = 'inhaler';
          selectedMedIndex.value = 4;
          print('index = $selectedMedIndex');
        }
    }
  }

  void selectMedTiming(index) {
    booleanTimingList.setAll(0, [false, false, false, false, false]);
    booleanTimingList[index] = !booleanTimingList[index];
    switch (index) {
      case 0:
        {
          print('Before eat is selected');
          selectedMedTiming = 'Before eat';
        }

      case 1:
        {
          print('After eat is selected');
          selectedMedTiming = 'After eat';
        }

      case 2:
        {
          print('With food is selected');
          selectedMedTiming = 'With food';
        }

      case 3:
        {
          print('Before sleep is selected');
          selectedMedTiming = 'Before sleep';
        }
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
          print('selected = $selectedInjectionSite');
        }

      case 1:
        {
          selectedInjectionSite = 'Thigh';
          print('selected = $selectedInjectionSite');
        }

      case 2:
        {
          selectedInjectionSite = 'Buttocks';
          print('selected = $selectedInjectionSite');
        }

      case 3:
        {
          selectedInjectionSite = 'Hip';
          print('selected = $selectedInjectionSite');
        }

      case 4:
        {
          selectedInjectionSite = 'Abdomen';
          print('selected = $selectedInjectionSite');
        }

      case 5:
        {
          selectedInjectionSite = 'Upper arm';
          print('selected = $selectedInjectionSite');
        }

      case 6:
        {
          selectedInjectionSite = 'Forearm';
          print('selected = $selectedInjectionSite');
        }

      case 7:
        {
          selectedInjectionSite = 'Back of the hands';
          print('selected = $selectedInjectionSite');
        }

      case 8:
        {
          selectedInjectionSite = 'Front and back of the lower arm';
          print('selected = $selectedInjectionSite');
        }

      case 9:
        {
          selectedInjectionSite = 'Front elbow pit';
          print('selected = $selectedInjectionSite');
        }
    }
  }

  String? validateFrequency(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a frequency';
    }

    //* Custom validation: Check if the input follows the format "X times a day"
    final RegExp frequencyPattern =
        RegExp(r'^\d+\s+times\s+a\s+day$', caseSensitive: false);
    if (!frequencyPattern.hasMatch(value)) {
      return 'Invalid format. Enter like "3 times a day"';
    }
    return null; //? Return null if input is valid.
  }
}
