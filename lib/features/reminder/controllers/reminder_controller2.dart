import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController2 extends GetxController {
  static ReminderController2 get instance => Get.find();

  //* variables
  final medicationName = TextEditingController();
  final medicationDose = TextEditingController();
  GlobalKey<FormState> frequencyFormKey = GlobalKey<FormState>();
  RxList<bool> booleanTypeList = [false, false, false, false, false].obs;
  RxList<bool> booleanTimingList =
      [false, false, false, false, false, false].obs;
  String selectedMedType = '';
  RxInt selectedMedIndex = 0.obs;
  String selectedMedTiming = '';

  //* methods
  selectMedType(index) {
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

  selectMedTiming(index) {
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
}
