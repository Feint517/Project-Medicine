import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/data/medication/treatment_model.dart';
import 'package:project_med/data/services/database_service.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/utils/constants/sizes.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReminderController());
    final database = Get.put(DatabaseService());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                List<dynamic>? treatments = await database.fetchAll(
                  table: 'treatments',
                );
                int? numberOfItems =
                    await database.getCount(table: 'treatments');
                if (numberOfItems == 0) {
                  print('there is no element');
                } else {
                  if (kDebugMode) {
                    print('Number of items = $numberOfItems');
                    print(treatments);
                    print(
                        'id of last element = ${treatments![(treatments.length) - 1].id}');
                    print(
                        'name of the first element: ${treatments[(treatments.length) - 1].name}');
                    print(
                        'date of the first elemnt = ${treatments[(treatments.length) - 1].date}');
                  }
                }
              },
              child: const Text('get list'),
            ),
            const Gap(TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () {},
              child: const Text('test fetching by date'),
            ),
            const Gap(TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () async {
                TreatmentModel treatment = TreatmentModel(
                  id: await controller.assignId(),
                  type: 'test',
                  name: 'test',
                  frequency: 'test',
                  timing: 'test',
                  date: 54484842,
                  hour: 'test',
                );
                database.add(
                  object: treatment,
                  table: 'treatments',
                );
                if (kDebugMode) {
                  print(treatment.id);
                  print(treatment.name);
                }
              },
              child: const Text('add'),
            ),
            const Gap(TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () {
                database.deleteAll(table: 'treatments');
              },
              child: const Text('delete all'),
            ),
            const Gap(TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () async {
                database.delete(table: 'treatments', id: 2);
              },
              child: const Text('delete'),
            ),
          ],
        ),
      ),
    );
  }
}
