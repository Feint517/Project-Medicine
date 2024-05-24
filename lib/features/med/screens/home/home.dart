import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/med/screens/home/widgets/countdown_timer.dart';
import 'package:project_med/features/med/screens/home/widgets/home_appbar.dart';
import 'package:project_med/features/news/controllers/news_controller.dart';
import 'package:project_med/features/news/screens/widgets/article_tile.dart';
import 'package:project_med/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  //* appbar
                  HomeAppBar(),
                  Gap(TSizes.spaceBtwSections / 2),
                  CountdownTimer()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                    child: Text(
                      'Latest medical news:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Gap(TSizes.spaceBtwInputFields),
                  Obx(
                    () => ListView.separated(
                      primary: true,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Column(
                        children: [
                          Gap(TSizes.spaceBtwItems / 2),
                          Divider(
                            thickness: 0.5,
                            indent: 25,
                            endIndent: 25,
                          ),
                          Gap(TSizes.spaceBtwItems / 2),
                        ],
                      ),
                      itemCount: controller.articlesRx.length,
                      itemBuilder: (context, index) {
                        final article = controller.articlesRx[index];
                        return ArticleTile(
                          author: article.author,
                          title: article.title,
                          url: article.url,
                          urlToImage: article.urlToImage,
                        );
                      },
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
