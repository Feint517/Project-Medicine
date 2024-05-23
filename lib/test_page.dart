import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/countdown_controller.dart';
import 'package:project_med/utils/constants/sizes.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountdownController());
    bool isThereTreatment = true;
    if (controller.nextTreatment != null) {
      isThereTreatment = true;
    } else {
      isThereTreatment = false;
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: isThereTreatment
                  ? TimerCountdown(
                      format: CountDownTimerFormat.daysHoursMinutesSeconds,
                      enableDescriptions: false,
                      endTime: controller.nextTreatmentDateRx.value!,
                      onEnd: () {
                        return;
                      },
                    )
                  : const SizedBox(),
            ),
            const Gap(TSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () async {
                controller.findNextMedication();
              },
              child: const Text('testing'),
            )
          ],
        ),
      ),
    );
  }
}
