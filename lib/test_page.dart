import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/news/controllers/news_controller.dart';
import 'package:project_med/utils/constants/sizes.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    return Scaffold(
      body: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) =>
              const Gap(TSizes.spaceBtwSections / 2),
          itemCount: controller.RxArticles.length,
          itemBuilder: (context, index) {
            return const ListTile();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.fetchArticles();
      }),
    );
  }
}
