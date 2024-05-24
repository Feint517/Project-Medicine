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
      text:
          '0'); //? default value in case it's not specified, changing the value from 0 can cause issuses
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
  var formattedDate = ''.obs;
  var formattedHour = ''.obs;
  RxList<TreatmentModel> treatmentsList = <TreatmentModel>[].obs;
  //*============================//*
  TreatmentModel? nextTreatment;
  DateTime nextTreatmentFullDate = DateTime.now();
  var nextTreatmentDateRx = Rxn<DateTime>();
  RxBool treatmentExist = false.obs;
  //*============================//*

  @override
  void onInit() {
    findNextMedication();
    super.onInit();
  }

  //* methods

  findNextMedication() async {
    List<TreatmentModel> treatmentsList = await fetchTreatments();
    if (treatmentsList.isEmpty) {
      treatmentExist.value = false;
      return null;
    }
    treatmentsList.sort(
      (a, b) => a.date.compareTo(b.date),
    );

    for (var treatment in treatmentsList) {
      //* convert it to one DateTime Object
      var dt = DateTime.fromMillisecondsSinceEpoch(treatment.date);
      var splited = treatment.hour.split(':');
      int hour = int.parse(splited[0]);
      int minute = int.parse(splited[1]);
      DateTime fullDate = DateTime(
        dt.year,
        dt.month,
        dt.day,
        hour,
        minute,
      );
      if (fullDate.isAfter(DateTime.now())) {
        nextTreatment = treatment;
        nextTreatmentFullDate = fullDate;
        nextTreatmentDateRx.value = fullDate;

        treatmentExist.value = true;
        break;
      }
    }
    return null;
  }

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
          selectedMedType = 'Injection';
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
        selectedMedTiming = 'Before eat';

      case 1:
        selectedMedTiming = 'After eat';

      case 2:
        selectedMedTiming = 'With food';

      case 3:
        selectedMedTiming = 'Before sleep';
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
        selectedInjectionSite = 'Upper arm';

      case 1:
        selectedInjectionSite = 'Thigh';

      case 2:
        selectedInjectionSite = 'Buttocks';

      case 3:
        selectedInjectionSite = 'Hip';

      case 4:
        selectedInjectionSite = 'Abdomen';

      case 5:
        selectedInjectionSite = 'Upper arm';

      case 6:
        selectedInjectionSite = 'Forearm';

      case 7:
        selectedInjectionSite = 'Back of the hands';

      case 8:
        selectedInjectionSite = 'Front and back of the lower arm';

      case 9:
        selectedInjectionSite = 'Front elbow pit';
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
    selectedDateInt = value.millisecondsSinceEpoch;
    formattedDate.value = DateFormat('yyyy-MM-dd').format(value);

    Get.back();
  }

  void selectHour(time) {
    formattedHour.value = DateFormat.Hm().format(time);
  }

  void saveMedication() async {
    int myInt = 0;
    if (medicationDose.text.isNotEmpty) {
      myInt = int.parse(medicationDose.text);
    }

    database.add(
      object: TreatmentModel(
        id: await assignId(),
        type: selectedMedType,
        name: medicationName.text,
        dose: myInt,
        frequency: medicationFrequency.text,
        timing: selectedMedTiming.toLowerCase(),
        injectingSite: selectedInjectionSite,
        date: selectedDateInt,
        hour: formattedHour.value,
      ),
      table: tableName,
    );

    treatmentExist.value = true;
    Get.off(() => const NavigationMenu());
  }

  Future<List<TreatmentModel>> fetchTreatments() async {
    List<TreatmentModel> treatments = await database.fetchAll(
      table: 'treatments',
      factory: (data) => TreatmentModel.fromJson(data),
    );
    return treatments;
  }

  void deleteTreatment({required int id}) async {
    database.deleteById(table: tableName, id: id);
  }

  void fetchTreatmentsByDate({required int convertedDate}) async {
    treatmentsList.clear();
    final result = await database.fetchTreatmentsFromDate(
      table: tableName,
      convertedDate: convertedDate,
    );
    for (var i = 0; i < result.length; i++) {
      treatmentsList.add(result[i]);
    }
  }

  bool validateEnteries() {
    switch (selectedMedIndex.value) {
      case 0:
        {
          if (medicationName.text.isEmpty ||
              medicationDose.text.isEmpty ||
              medicationFrequency.text.isEmpty ||
              selectedMedTiming.isEmpty ||
              formattedDate.value.isEmpty ||
              formattedHour.value.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return false;
          }
          return true;
        }
      case 1:
        {
          if (medicationName.text.isEmpty ||
              medicationFrequency.text.isEmpty ||
              selectedMedTiming.isEmpty ||
              formattedDate.value.isEmpty ||
              formattedHour.value.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return false;
          }
        }
      case 2:
        {
          if (medicationName.text.isEmpty ||
              medicationDose.text.isEmpty ||
              selectedMedTiming.isEmpty ||
              formattedDate.value.isEmpty ||
              formattedHour.value.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return false;
          }
          return true;
        }
      case 3:
        {
          if (medicationName.text.isEmpty ||
              selectedMedTiming.isEmpty ||
              selectedInjectionSite.isEmpty ||
              formattedDate.value.isEmpty ||
              formattedHour.value.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return false;
          }
          return true;
        }
      case 4:
        {
          if (medicationName.text.isEmpty ||
              medicationFrequency.text.isEmpty ||
              formattedDate.value.isEmpty ||
              formattedHour.value.isEmpty) {
            CustomLoaders.warningSnackBar(title: 'Please enter valid info.');
            return false;
          }
          return true;
        }
    }
    return false;
  }

  void clearEverything() {
    booleanTypeList.setAll(0, [false, false, false, false, false]);
    selectedMedIndex.value = 10;
    selectedMedType = '';
    medicationName.clear();
    medicationDose.clear();
    medicationFrequency.clear();
    booleanTimingList.setAll(0, [false, false, false, false, false]);
    selectedMedTiming = '';
    booleanInjectSiteList.setAll(0,
        [false, false, false, false, false, false, false, false, false, false]);
    selectedInjectionSite = '';
    formattedDate.value = '';
    formattedHour.value = '';
  }
}
