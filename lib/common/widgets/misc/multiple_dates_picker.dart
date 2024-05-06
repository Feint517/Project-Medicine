import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller2.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MultipleDatesPicker extends StatelessWidget {
  const MultipleDatesPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController2());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SfDateRangePicker(
          backgroundColor: TColors.black,
          selectionTextStyle: const TextStyle(color: TColors.white),
          selectionColor: TColors.primary,
          headerStyle: const DateRangePickerHeaderStyle(
            backgroundColor: Colors.transparent,
            textAlign: TextAlign.left,
            textStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 5,
              color: TColors.white,
            ),
          ),
          minDate: DateTime(2024, 01, 01, 10, 0, 0),
          enablePastDates: false,
          todayHighlightColor: TColors.primary,
          view: DateRangePickerView.month,
          viewSpacing: 10,
          selectionMode: DateRangePickerSelectionMode.multiple,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          navigationDirection: DateRangePickerNavigationDirection.vertical,
          navigationMode: DateRangePickerNavigationMode.scroll,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7, //? to make sunday the first day of the week
            showWeekNumber: true,
            weekNumberStyle: DateRangePickerWeekNumberStyle(
              textStyle: const TextStyle(fontStyle: FontStyle.italic),
              backgroundColor: TColors.primary.withOpacity(0.5),
            ),
          ),
          showActionButtons: true,
          onSubmit: (value) {
            controller.selectDate(value);
          },
          onCancel: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
