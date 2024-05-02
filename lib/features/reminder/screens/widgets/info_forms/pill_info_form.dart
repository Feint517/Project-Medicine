import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller2.dart';
import 'package:project_med/features/reminder/screens/widgets/selecting_tile.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/validators/validators.dart';

class PillInfoForm extends StatelessWidget {
  const PillInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController2());
    List<String> timings = [
      'Before eat',
      'After eat',
      'With food',
      'Before sleep'
    ];
    return Form(
      key: controller.frequencyFormKey, //? assign the key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pill name:'),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationName,
            validator: (value) =>
                TValidator.validateEmptyText('Pill name', value),
          ),
          const Gap(TSizes.spaceBtwSections / 1.5),
          const Text('Dose:'),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationDose,
            keyboardType: TextInputType.number,
            validator: (value) => TValidator.validateEmptyText('Dose', value),
          ),
          const Gap(TSizes.spaceBtwSections / 1.5),
          const Text('Timing:'),
          const Gap(TSizes.spaceBtwItems),
          SizedBox(
            height: 42,
            child: ListView.builder(
              itemCount: timings.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Obx(
                () => SelectingContainer(
                  name: timings[index],
                  backgroundColor: controller.booleanTimingList[index]
                      ? TColors.primary
                      : Colors.transparent,
                  onTap: () {
                    controller.selectMedTiming(index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
