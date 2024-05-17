import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class HourPicker extends StatelessWidget {
  const HourPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(TTexts.hour),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: Time(hour: 20, minute: 40),
                    sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                    sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                    duskSpanInMinutes: 120, // optional
                    onChange: (onTimeChanged) {},
                    onChangeDateTime: (time) {
                      controller.selectHour(time);
                    },
                  ),
                );
              },
              icon: const Icon(Iconsax.timer),
            ),
          ],
        ),
        const Gap(TSizes.spaceBtwItems),
        Container(
          width: THelperFunctions.screenWidth(),
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Obx(
              () {
                if (controller.formattedHour.value.isEmpty) {
                  return const Text('No hour is selected...');
                } else {
                  return Text(controller.formattedHour!.value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
