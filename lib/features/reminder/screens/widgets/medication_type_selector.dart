import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller2.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_types.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/image_strings.dart';

class MedicationTypeSelector extends StatelessWidget {
  const MedicationTypeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController2());
    List<String> names = ['Pill', 'Eye drop', 'Liquid', 'Injection', 'Inhaler'];
    List<String> illustrations = [
      TImages.pill,
      TImages.eyeDrop,
      TImages.liquid,
      TImages.injection,
      TImages.inhaler,
    ];
    return SizedBox(
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
    );
  }
}
