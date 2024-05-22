import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/widgets/date_picker.dart';
import 'package:project_med/features/reminder/screens/widgets/hour_picker.dart';
import 'package:project_med/features/reminder/screens/widgets/selecting_tile.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';
import 'package:project_med/utils/validators/validators.dart';

class InjectionInfoForm extends StatelessWidget {
  const InjectionInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    List<String> injectionSites = [
      'Upper arm',
      'Thigh',
      'Buttocks',
      'Hip',
      'Abdomen',
      'Upper arm',
      'Forearm',
      'Back of the hands',
      'Front and back of the lower arm',
      'Front elbow pit',
    ];
    final controller = Get.put(ReminderController());
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
          const Text(TTexts.injectionName),
          const Gap(TSizes.spaceBtwItems),
          TextFormField(
            controller: controller.medicationName,
            validator: (value) =>
                TValidator.validateEmptyText('Injection name', value),
          ),
          const Gap(TSizes.spaceBtwSections / 1.5),
          // const Text(TTexts.dose),
          // const Gap(TSizes.spaceBtwItems),
          // TextFormField(
          //   controller: controller.medicationDose,
          //   keyboardType: TextInputType.number,
          //   validator: (value) => TValidator.validateEmptyText('Dose', value),
          // ),
          // const Gap(TSizes.spaceBtwSections / 1.5),
          const Text(TTexts.timing),
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
          const Gap(TSizes.spaceBtwSections / 1.5),
          const Text('Injecting site:'),
          const Gap(TSizes.spaceBtwItems),
          SizedBox(
            height: 42,
            child: ListView.builder(
              itemCount: injectionSites.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Obx(
                () => SelectingContainer(
                  name: injectionSites[index],
                  backgroundColor: controller.booleanInjectSiteList[index]
                      ? TColors.primary
                      : isDarkMode
                          ? TColors.black
                          : TColors.white,
                  onTap: () {
                    controller.selectInjectionSite(index);
                  },
                ),
              ),
            ),
          ),
          const Gap(TSizes.spaceBtwSections / 1.5),
          const DatePicker(),
          const Gap(TSizes.spaceBtwSections / 1.5),
          const HourPicker(),
          const Gap(TSizes.spaceBtwSections / 1.5),
        ],
      ),
    );
  }
}
