import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/news/controllers/news_controller.dart';
import 'package:project_med/features/news/screens/widgets/article_tile.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchArticles();
        },
      ),
    );
  }
}
