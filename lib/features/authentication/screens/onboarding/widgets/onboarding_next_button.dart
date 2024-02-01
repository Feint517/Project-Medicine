import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/device/device_utility.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: 10, //Tsizes default space
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primary : Colors.black,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}