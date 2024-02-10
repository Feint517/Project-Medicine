import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/common/widgets/misc/custom_date_picker_widget.dart';
import 'package:project_med/features/reminder/screens/widgets/medication_types.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class MedReminderScreen extends StatelessWidget {
  const MedReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    List<Widget> medTypes = [
      const MedicationTypes(image: TImages.pill, title: 'Pill'),
      const MedicationTypes(image: TImages.eyeDrop, title: 'Eye drop'),
      const MedicationTypes(image: TImages.liquid, title: 'Liquid'),
      const MedicationTypes(image: TImages.injection, title: 'Injection'),
      const MedicationTypes(image: TImages.inhaler, title: 'Inhaler'),
    ];
    List<Widget> timing = [
      const MedTimingSelector(name: 'Before eat'),
      const MedTimingSelector(name: 'After eat'),
      const MedTimingSelector(name: 'With food'),
      const MedTimingSelector(name: 'Before sleep'),
    ];
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
                  const Gap(TSizes.spaceBtwSections / 2),
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create\nNew Schedule',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Gap(TSizes.spaceBtwItems),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: TColors.primary,
                              builder: (context) => Container(
                                height: THelperFunctions.screenHeight() * 0.7,
                                decoration: const BoxDecoration(
                                  //color: TColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        TSizes.defaultSpace),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            itemCount: medTypes.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_, index) {
                                              return medTypes[index];
                                            },
                                          ),
                                        ),
                                        const Gap(TSizes.spaceBtwItems),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Pill name'),
                                            const Gap(TSizes.spaceBtwItems),
                                            TextFormField(),
                                          ],
                                        ),
                                        const Gap(TSizes.spaceBtwSections),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Dose'),
                                                const Gap(TSizes.spaceBtwItems),
                                                SizedBox(
                                                  width: THelperFunctions
                                                          .screenWidth() *
                                                      0.4,
                                                  child: TextFormField(),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Type'),
                                                const Gap(TSizes.spaceBtwItems),
                                                SizedBox(
                                                  width: THelperFunctions
                                                          .screenWidth() *
                                                      0.4,
                                                  child: TextFormField(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Gap(TSizes.spaceBtwItems),
                                        SizedBox(
                                          height: 42,
                                          child: ListView.builder(
                                            itemCount: timing.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_, index) {
                                              return timing[index];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
            CustomDatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: TColors.secondary,
              selectedTextColor: TColors.white,
              //deactivatedColor: TColors.secondary,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: TColors.grey,
              ),
              dayTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: TColors.grey,
              ),
              monthTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: TColors.grey,
              ),
              onDateChange: (date) {
                selectedDate = date;
              },
            )
          ],
        ),
      ),
    );
  }
}

// class CurrentDate extends StatelessWidget {
//   const CurrentDate({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               DateFormat.yMMMd().format(DateTime.now()),
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const Gap(TSizes.spaceBtwItems / 2),
//             Text(
//               'Today',
//               style: Theme.of(context).textTheme.headlineMedium,
//             )
//           ],
//         ),
//         ElevatedButton(onPressed: () {}, child: const Icon(Iconsax.add)),
//       ],
//     );
//   }
// }

class MedTimingSelector extends StatelessWidget {
  const MedTimingSelector({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(
          right: TSizes.spaceBtwItems,
        ),
        child: Container(
          width: 120,
          decoration: const BoxDecoration(
            color: TColors.secondary,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
