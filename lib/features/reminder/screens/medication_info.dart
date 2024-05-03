import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller2.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forms/eyedrop_info_form.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forms/inhaler_info_form.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forms/injection_info_form.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forms/liquid_info_form.dart';
import 'package:project_med/features/reminder/screens/widgets/info_forms/pill_info_form.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_type_selector.dart';
import 'package:project_med/navigation_menu.dart';
import 'package:project_med/utils/constants/sizes.dart';

class MedicationInfoScreen extends StatelessWidget {
  const MedicationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController2());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomPrimaryHeaderContainer(
              child: Gap(TSizes.spaceBtwSections * 2),
            ),
            IconButton(
              onPressed: () => Get.off(() => const NavigationMenu()),
              icon: const Icon(Iconsax.arrow_circle_down4),
              iconSize: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MedicationTypeSelector(),
                  const Gap(TSizes.spaceBtwItems),
                  Obx(
                    () {
                      switch (controller.selectedMedIndex.value) {
                        case 0:
                          return const PillInfoForm();
                        case 1:
                          return const EyedropInfoForm();
                        case 2:
                          return const LiquidInfoForm();
                        case 3:
                          return const InjectionInfoForm();
                        case 4:
                          return const InhalerInfoForm();
                        default:
                          return const SizedBox(
                            height: 50,
                          );
                      }
                    },
                  ),
                  const Gap(TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //controller.addMedication();
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
