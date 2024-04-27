import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/data/services/database_service.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
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
                      controller: controller.searchedDrug,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.search_zoom_in),
                        labelText: TTexts.drugSearch,
                      ),
                    ),
                    const Gap(TSizes.spaceBtwItems),
                    OutlinedButton(
                      onPressed: () {
                        controller.searchDrug(controller.searchedDrug.text);
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

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrugSearchController());
    final durgsDB = Get.put(DatabaseService());
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
      ),
      child: Obx(
        () => ListView.separated(
          itemCount: controller.searchResult!.value.length,
          itemBuilder: (context, index) {},
          separatorBuilder: (context, index) =>
              const Gap(TSizes.spaceBtwItems / 2),
        ),
      ),

      // child: FutureBuilder(
      //   future: controller.searchResult,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else {
      //       final drugs = snapshot.data;
      //       return drugs == null
      //           ? const Center(
      //               child: Text(
      //                 'No Drugs...',
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 28,
      //                 ),
      //               ),
      //             )
      //           : ListView.separated(
      //               physics:
      //                   const NeverScrollableScrollPhysics(), //? to stop the scrolling in the ListView
      //               shrinkWrap: true,
      //               separatorBuilder: (context, index) =>
      //                   const Gap(TSizes.spaceBtwItems / 2),
      //               itemCount: drugs.length,
      //               itemBuilder: (context, index) {
      //                 final todo = drugs[index];
      //                 return ListTile(
      //                   title: Text(
      //                     todo.drugName,
      //                     style: const TextStyle(fontWeight: FontWeight.bold),
      //                   ),
      //                 );
      //               },
      //             );
      //     }
      //   },
      // ),
    );
  }
}
