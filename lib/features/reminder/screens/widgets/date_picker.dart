import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/misc/multiple_dates_picker.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(TTexts.date),
            Icon(
              Iconsax.calendar,
              color: TColors.primary,
            ),
          ],
        ),
        const Gap(TSizes.spaceBtwItems),
        GestureDetector(
          onTap: () {
            //controller.finalList.clear();
            Get.to(() => const MultipleDatesPicker());
          },
          child: Container(
            width: THelperFunctions.screenWidth(),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Obx(
                () {
                  if (controller.formattedDate.isEmpty) {
                    return const Text('No date is selected...');
                  } else {
                    return Text(
                      controller.formattedDate.value,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
