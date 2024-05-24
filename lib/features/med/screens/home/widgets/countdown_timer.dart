import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
//import 'package:project_med/features/reminder/controllers/countdown_controller.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    return Obx(
      () {
        switch (controller.treatmentExist.value) {
          case true:
            return SizedBox(
              height: 170,
              width: THelperFunctions.screenHeight(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Time untill your next medication',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: TColors.white),
                    ),
                    TimerCountdown(
                      format: CountDownTimerFormat.daysHoursMinutes,
                      enableDescriptions: true,
                      timeTextStyle: const TextStyle(
                        color: TColors.white,
                        fontSize: 18,
                      ),
                      colonsTextStyle: const TextStyle(
                        color: TColors.white,
                        fontSize: 18,
                      ),
                      descriptionTextStyle: const TextStyle(
                        color: TColors.white,
                        fontSize: 18,
                      ),
                      endTime: controller.nextTreatmentDateRx.value!,
                      onEnd: () {},
                    ),
                    const Gap(TSizes.spaceBtwSections / 1.5),
                  ],
                ),
              ),
            );
          case false:
            return const SizedBox(
              height: 75,
            );
        }
      },
    );
  }
}
