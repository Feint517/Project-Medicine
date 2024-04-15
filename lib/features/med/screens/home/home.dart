import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/data/database_helper.dart';
import 'package:project_med/features/med/screens/home/widgets/home_appbar.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DatabaseHelper());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  //* appbar
                  const HomeAppBar(),
                  const Gap(TSizes.spaceBtwSections),
                  Text(
                    'Just a placeholder',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: TColors.white),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
            //const Text('just a place holder 2'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.global_search),
                      labelText: TTexts.homeSearch,
                    ),
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  SizedBox(
                    width:
                        double.infinity, //? to make the sized button full width
                    child: OutlinedButton(
                      onPressed: () {
                        //DatabaseHelper.instance.initDatabase();
                        controller.initDatabase();
                      },
                      child: const Text('Testing the Database'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
