import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/medication_info.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_tile_dismissible.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class MedReminderScreen extends StatelessWidget {
  const MedReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: Text(
                      'Medication',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections / 3),
                  const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDayTimeline(),
                      ],
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Take',
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                      IconButton(
                        onPressed: () => Get.to(
                          () => const MedicationInfoScreen(),
                          transition: Transition.downToUp,
                        ),
                        icon: const Icon(
                          Iconsax.add,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const Gap(TSizes.spaceBtwSections),
                  Obx(
                    () => ListView.separated(
                      physics:
                          const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const Gap(TSizes.spaceBtwItems / 2),
                      itemCount: controller.medicationList.length,
                      itemBuilder: (context, index) {
                        final medication = controller.medicationList[index];
                        return MedicationTile(
                          list: controller.medicationList,
                          index: index,
                          name: medication.name,
                          dose: medication.dosage,
                          type: medication.type,
                          timing: medication.timing,
                        );
                      },
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDayTimeline extends StatelessWidget {
  const CustomDayTimeline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //*`selectedDate` the new date selected.
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
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
