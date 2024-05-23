import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/reminder/controllers/countdown_controller.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class MedicationTile extends StatelessWidget {
  const MedicationTile({
    super.key,
    required this.id,
    required this.name,
    required this.dose,
    required this.type,
    required this.timing,
    required this.list,
    required this.date,
    required this.hour,
  });

  final int id;
  final String name;
  final int dose;
  final String type;
  final String timing;
  final List list;
  final int date;
  final String hour;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    final countdown = Get.put(CountdownController());
    return Dismissible(
      key: ValueKey<List>(list),
      direction: DismissDirection.startToEnd, //? swipe from left to right
      onDismissed: (direction) async {
        controller.deleteTreatment(id: id);
        controller.fetchTreatmentsByDate(convertedDate: date);
        countdown.findNextMedication();
        if (direction == DismissDirection.startToEnd) {
          controller.deleteTreatment(id: id);
          controller.fetchTreatmentsByDate(convertedDate: date);
          countdown.findNextMedication();
        }
      },
      background: Container(
        width: THelperFunctions.screenWidth() * 0.9,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(37),
        ),
        child: Row(
          children: [
            const Gap(TSizes.sm),
            const Icon(Icons.delete),
            const Gap(TSizes.md),
            Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onDoubleTap: () {
          if (kDebugMode) {
            print('id = $id');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(TSizes.md),
          width: THelperFunctions.screenWidth() * 0.9,
          height: 100,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(37),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (type == 'Pill')
                const Image(image: AssetImage(TImages.pill))
              else if (type == 'Eye Drop')
                const Image(image: AssetImage(TImages.eyeDrop))
              else if (type == 'Liquid')
                const Image(image: AssetImage(TImages.liquid))
              else if (type == 'Injection')
                const Image(image: AssetImage(TImages.injection))
              else
                const Image(image: AssetImage(TImages.inhaler)),
              SizedBox(
                width: THelperFunctions.screenWidth() * 0.37,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: TColors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$dose $timing',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.white),
                    ),
                  ],
                ),
              ),
              Text(
                hour,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
