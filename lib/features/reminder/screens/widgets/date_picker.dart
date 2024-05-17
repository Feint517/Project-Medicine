import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/misc/multiple_dates_picker.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
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
            const Text(TTexts.date),
            IconButton(
              onPressed: () {
                controller.finalList.clear();
                Get.to(() => const MultipleDatesPicker());
              },
              icon: const Icon(Iconsax.calendar),
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
                if (controller.finalList.isEmpty) {
                  return const Text('No date is selected...');
                } else {
                  return Text(
                    controller.finalList.join(' , '),
                    overflow: TextOverflow.ellipsis,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
