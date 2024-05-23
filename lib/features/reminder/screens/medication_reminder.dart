import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/common/widgets/misc/custom_day_timeline.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/medication_info.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_tile_dismissible.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

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
                          color: TColors.primary,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const Gap(TSizes.spaceBtwSections / 4),
                  Obx(
                    () => ListView.separated(
                      physics:
                          const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const Gap(TSizes.spaceBtwSections / 2),
                      itemCount: controller.treatmentsList.length,
                      itemBuilder: (context, index) {
                        final treatment = controller.treatmentsList[index];
                        return MedicationTile(
                          list: controller.treatmentsList,
                          id: treatment.id,
                          name: treatment.name,
                          dose: treatment.dose,
                          type: treatment.type,
                          timing: treatment.timing,
                          date: treatment.date,
                          hour: treatment.hour,
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
