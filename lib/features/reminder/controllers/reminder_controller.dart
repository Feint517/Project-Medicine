import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/medication/medication_model.dart';
import 'package:project_med/features/reminder/screens/medication_reminder.dart';

class ReminderController extends GetxController {
  static ReminderController get instance => Get.find();

  //* variables
  final medicationName = TextEditingController();
  final medicationDose = TextEditingController();
  final medicationVolume = TextEditingController(); //? in case of liquid
  final medicationFrequency = TextEditingController(); //? for eye drops
  Rx<String> medicationType = ''.obs;
  String medicationTiming = '';
  String injectionSite = '';
  GlobalKey<FormState> frequencyFormKey = GlobalKey<FormState>();
  RxList<MedicationModel> medicationList = <MedicationModel>[].obs;
  RxList<bool> booleanTypeList = [false, false, false, false, false].obs;
  RxList<bool> booleanTimingList = [false, false, false, false, false].obs;
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

  void selectInjectionType(index) {
    booleanInjectSiteList.setAll(0,
        [false, false, false, false, false, false, false, false, false, false]);
    booleanInjectSiteList[index] = !booleanInjectSiteList[index];

    switch (index) {
      case 0:
        injectionSite = 'Upper arm';
      case 1:
        injectionSite = 'Thigh';
      case 2:
        injectionSite = 'Buttocks';
      case 3:
        injectionSite = 'Hip';
      case 4:
        injectionSite = 'Abdomen';
      case 5:
        injectionSite = 'Upper arm';
      case 6:
        injectionSite = 'Forearm';
      case 7:
        injectionSite = 'Back of the hands';
      case 8:
        injectionSite = 'Front and back of the lower arm';
      case 9:
        injectionSite = 'Front elbow pit';
    }
  }

  void selectMedType(index) {
    booleanTypeList.setAll(0, [false, false, false, false, false]);
    booleanTypeList[index] = !booleanTypeList[index];
    switch (index) {
      case 0:
        medicationType.value = 'Pill';
      case 1:
        medicationType.value = 'Eye drop';
      case 2:
        medicationType.value = 'Liquid';
      case 3:
        medicationType.value = 'Injection';
      case 4:
        medicationType.value = 'Inhaler';
    }
  }

  void selectMedTiming(index) {
    booleanTimingList.setAll(0, [false, false, false, false, false]);
    booleanTimingList[index] = !booleanTimingList[index];
    switch (index) {
      case 0:
        medicationTiming = 'Before eat';
      case 1:
        medicationTiming = 'After eat';
      case 2:
        medicationTiming = 'With food';
      case 3:
        medicationTiming = 'Before sleep';
    }
  }

  void addMedication() {
    try {
      if (!frequencyFormKey.currentState!.validate()) {
        return;
      }
      final newMedicaion = MedicationModel(
        name: medicationName.text,
        dosage: medicationDose.text,
        type: medicationType.value,
        voulume: medicationVolume.text,
        timing: medicationTiming,
      );
      medicationList.add(newMedicaion);
      medicationName.clear();
      medicationDose.clear();
      Get.off(
        () => const MedReminderScreen(),
        transition: Transition.upToDown,
      );
    } catch (e) {
      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  void removeMedication(index) {
    medicationList.removeAt(index);
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
