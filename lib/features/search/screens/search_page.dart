import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
import 'package:project_med/features/search/screens/widgets/search_result.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrugSearchController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: Text(
                        'Search',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white),
                      ),
                    ),
                    const Gap(TSizes.spaceBtwSections),
                    TextFormField(
                      controller: controller.searchedDrug1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.search_zoom_in),
                        labelText: TTexts.drugSearch1,
                      ),
                    ),
                    const Gap(TSizes.spaceBtwInputFields),
                    // TextFormField(
                    //   controller: controller.searchedDrug2,
                    //   decoration: const InputDecoration(
                    //     prefixIcon: Icon(Iconsax.search_zoom_in),
                    //     labelText: TTexts.drugSearch2,
                    //   ),
                    // ),
                    const Gap(TSizes.spaceBtwSections / 2),
                    OutlinedButton(
                      onPressed: () {
                        controller.searchDrug();
                      },
                      child: const Text('Search'),
                    ),
                    const Gap(TSizes.spaceBtwSections * 1.5),
                  ],
                ),
              ),
            ),
            const SearchResult(),
          ],
        ),
      ),
    );
  }
}

class DrugTile extends StatelessWidget {
  const DrugTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
