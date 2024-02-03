import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/authentication/controllers/onboarding_controller.dart';
import 'package:project_med/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:project_med/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:project_med/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:project_med/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:project_med/utils/constants/animations.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //? Get the instance of the obBoarding controller
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //? horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                animation: TAnimations.onBoarding1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              // OnBoardingPage(
              //   animation: TAnimations.onBoarding2,
              //   title: TTexts.onBoardingTitle2,
              //   subtitle: TTexts.onBoardingSubTitle2,
              // ),
              OnBoardingPage(
                animation: TAnimations.onBoarding3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          //? skip button
          const OnBoardingSkip(),

          //? dot naviagator smoothPageIndicator
          const OnBoardingDotNavigation(),

          //? circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}


