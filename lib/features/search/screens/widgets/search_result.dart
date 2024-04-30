import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
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
        () => controller.searchResult.isEmpty
            ? const Center(
                child: Text(
                  'No interactions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
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
                  return ListTile(
                    title: Text(
                      interaction.drugName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            
      ),
    );
  }
}