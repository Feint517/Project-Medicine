import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrugSearchController());
    return CustomPrimaryHeaderContainer(
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
              controller: controller.searchedDrug,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.search_zoom_in),
                labelText: TTexts.drugSearch1,
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: TColors.white),
                floatingLabelStyle: const TextStyle(color: TColors.white),
              ),
            ),
            const Gap(TSizes.spaceBtwSections / 2),
            OutlinedButton(
              onPressed: () {
                controller.searchInteraction();
              },
              child: Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: TColors.white),
              ),
            ),
            const Gap(TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
