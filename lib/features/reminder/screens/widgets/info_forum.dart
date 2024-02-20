import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/widgets/selecting_tile.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/validators/validators.dart';

class InfoForum extends StatelessWidget {
  const InfoForum({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> timings = [
      'Before eat',
      'After eat',
      'With food',
      'Before sleep'
    ];
    final controller = Get.put(ReminderController());
    return Form(
      key: controller.frequencyFormKey, //? assign the key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Medication name'),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationName,
            validator: (value) =>
                TValidator.validateEmptyText('Medication name', value),
          ),
          const Gap(TSizes.spaceBtwSections),
          const Text('Dose'),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationDose,
            keyboardType: TextInputType.number,
            validator: (value) => TValidator.validateEmptyText('Dose', value),
          ),
          const Gap(TSizes.spaceBtwSections),
          const Text('Frequency'),
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
            //keyboardType: TextInputType.number,
          ),
          const Gap(TSizes.spaceBtwSections),
          const Text('Timing'),
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
          const Gap(TSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
