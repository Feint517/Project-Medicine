import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
import 'package:project_med/features/search/screens/widgets/interaction_info_tile.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrugSearchController());
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
      ),
      child: Obx(
        () => controller.searched.value
            ? controller.searchResult.isEmpty
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/lottie/misc/checked.json',
                              repeat: false),
                          const Gap(TSizes.spaceBtwItems),
                          Text(
                            'No interactions found',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Make sure to ask your doctor before taking it',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.secondary),
                          )
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    physics:
                        const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const Gap(TSizes.spaceBtwItems / 2),
                    itemCount: controller.searchResult.length,
                    itemBuilder: (context, index) {
                      final interaction = controller.searchResult[index];
                      return InteractionInfoTile(
                        drug1: interaction.drug1Name,
                        drug2: interaction.drug2Name,
                        explanation: interaction.explanation,
                      );
                    },
                  )
            : const SizedBox(),
      ),
    );
  }
}
