import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/colors.dart';

class CustomDayTimeline extends StatelessWidget {
  const CustomDayTimeline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //*`selectedDate` the new date selected.
        int transformedDate = selectedDate.millisecondsSinceEpoch;
        if (kDebugMode) {
          // print('=======================================');
          // print('before transfrom selectedDate = $selectedDate');
          // print('after transfrom selectedDate = $transformedDate');
        }
        controller.fetchTreatmentsByDate(convertedDate: transformedDate);
      },
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: const DateFormatter.dayOnly(),
        selectedDateStyle: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
        monthStyle: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      activeColor: const Color(0xff85A389),
      dayProps: EasyDayProps(
        height: 70.0,
        width: 70.0,
        dayStructure: DayStructure.dayNumDayStr,
        activeDayStyle: const DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff3371FF),
                Color(0xff8426D6),
              ],
            ),
          ),
          //borderRadius: 20,
          dayStrStyle: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          dayNumStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: TColors.secondary,
        todayStyle: const DayStyle(
          borderRadius: 20,
          dayStrStyle: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          dayNumStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: TColors.secondary,
              width: 1,
            ),
          ),
          dayStrStyle: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          dayNumStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
