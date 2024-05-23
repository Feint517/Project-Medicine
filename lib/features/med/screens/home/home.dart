import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/med/screens/home/widgets/home_appbar.dart';
import 'package:project_med/features/news/controllers/news_controller.dart';
import 'package:project_med/features/news/screens/widgets/article_tile.dart';
import 'package:project_med/features/reminder/controllers/countdown_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    final countdown = Get.put(CountdownController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  //* appbar
                  const HomeAppBar(),
                  const Gap(TSizes.spaceBtwSections / 2),
                  Obx(
                    () {
                      switch (countdown.treatmentExist.value) {
                        case true:
                          return SizedBox(
                            height: 170,
                            width: THelperFunctions.screenHeight(),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Time untill your next medication:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: TColors.white),
                                  ),
                                  TimerCountdown(
                                    format:
                                        CountDownTimerFormat.daysHoursMinutes,
                                    enableDescriptions: true,
                                    timeTextStyle: const TextStyle(
                                      color: TColors.white,
                                      fontSize: 18,
                                    ),
                                    colonsTextStyle: const TextStyle(
                                      color: TColors.white,
                                      fontSize: 18,
                                    ),
                                    descriptionTextStyle: const TextStyle(
                                      color: TColors.white,
                                      fontSize: 18,
                                    ),
                                    endTime:
                                        countdown.nextTreatmentDateRx.value!,
                                    onEnd: () {
                                      print("Timer finished");
                                    },
                                  ),
                                  const Gap(TSizes.spaceBtwSections / 1.5),
                                ],
                              ),
                            ),
                          );
                        case false:
                          return const SizedBox(
                            height: 75,
                          );
                      }
                    },
                  )
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
                  Text(
                    'Latest medical news:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Gap(TSizes.spaceBtwInputFields),
                  Obx(
                    () => ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                          title: article.title
                              .substring(0, min(article.title.length, 150)),
                          url: article.url,
                          urlToImage: article.urlToImage,
                        );
                      },
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
