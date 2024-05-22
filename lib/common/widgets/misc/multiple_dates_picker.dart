import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MultipleDatesPicker extends StatelessWidget {
  const MultipleDatesPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ReminderController());
    return Center(
      child: SfDateRangePicker(
        onSubmit: (value) {
          controller.selectDate(value);
        },
        onCancel: () {
          Get.back();
        },
        backgroundColor: isDark ? TColors.black : TColors.white,
        selectionTextStyle: const TextStyle(color: TColors.white),
        selectionColor: TColors.primary,
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
          textAlign: TextAlign.left,
          textStyle: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 18,
            letterSpacing: 5,
            color: isDark ? TColors.white : TColors.black,
          ),
        ),
        minDate: DateTime(2024, 01, 01, 10, 0, 0),
        enablePastDates: false,
        todayHighlightColor: TColors.primary,
        view: DateRangePickerView.month,
        viewSpacing: 10,
        selectionMode: DateRangePickerSelectionMode.single,
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
      ),
    );
  }
}
