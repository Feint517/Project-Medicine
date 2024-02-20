import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/medication_reminder.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forum.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_types.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';

class MedicationInfoScreen extends StatelessWidget {
  const MedicationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    List<String> names = ['Pill', 'Eye drop', 'Liquid', 'Injection', 'Inhaler'];
    List<String> illustrations = [
      TImages.pill,
      TImages.eyeDrop,
      TImages.liquid,
      TImages.injection,
      TImages.inhaler,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomPrimaryHeaderContainer(
              child: Gap(TSizes.spaceBtwSections * 2),
            ),
            IconButton(
              onPressed: () => Get.off(() => const MedReminderScreen()),
              icon: const Icon(Iconsax.arrow_circle_down4),
              iconSize: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: names.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (conext, index) => Obx(
                        () => MedicationTypes(
                          image: illustrations[index],
                          title: names[index],
                          backgroundColor: controller.booleanTypeList[index]
                              ? TColors.primary
                              : Colors.transparent,
                          onTap: () {
                            controller.selectMedType(index);
                          },
                        ),
                      ),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  const InfoForum(),
                  const Gap(TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addMedication();
                      },
                      child: const Text('Save'),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
