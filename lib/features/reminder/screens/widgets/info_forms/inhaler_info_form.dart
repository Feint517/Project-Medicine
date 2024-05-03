import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller2.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';
import 'package:project_med/utils/validators/validators.dart';

class InhalerInfoForm extends StatelessWidget {
  const InhalerInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController2());
    // List<String> timings = [
    //   'Before eat',
    //   'After eat',
    //   'With food',
    //   'Before sleep'
    // ];
    return Form(
      key: controller.frequencyFormKey, //? assign the key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(TTexts.inhalerName),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationName,
            validator: (value) =>
                TValidator.validateEmptyText('Pill name', value),
          ),
          const Gap(TSizes.spaceBtwSections / 1.5),
          const Text('Frequency:'),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationFrequency,
            validator: (value) => controller.validateFrequency(value),
            decoration: const InputDecoration(
              hintText: 'Enter frequency (e.g., 3 times a day)',
              hintStyle: TextStyle(
                fontSize: 13,
                color: TColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}