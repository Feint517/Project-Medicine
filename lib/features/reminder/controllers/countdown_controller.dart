import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:project_med/data/services/database_service.dart';

class CountdownController extends GetxController {
  static CountdownController get instance => Get.find();
  final database = Get.put(DatabaseService());

  final tableName = 'treatments';
  List<TreatmentModel> treatmentsList = <TreatmentModel>[];
  TreatmentModel? nextTreatment;
  DateTime nextTreatmentFullDate = DateTime.now();
  var nextTreatmentDateRx = Rxn<DateTime>();
  RxBool treatmentExist = false.obs;

  @override
  void onInit() {
    findNextMedication();
    super.onInit();
  }

  findNextMedication() async {
    treatmentsList = await database.fetchAllTreatment(table: tableName);
    if (kDebugMode) {
      print('Number of treatments = ${treatmentsList.length}');
    }
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
        print('nextTreatmentFulldate = $fullDate');

        treatmentExist.value = true;
        break;
      }
    }
    if (nextTreatment != null) {
      if (kDebugMode) {
        print('==================');
        print('next treatment name: ${nextTreatment!.name}');
      }
    } else {
      print('treatments list is empty');
    }
    return null;
  }
}
