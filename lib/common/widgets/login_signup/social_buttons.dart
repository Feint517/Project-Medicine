import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/features/authentication/controllers/login/login_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              image: AssetImage(TImages.googleLogo),
              height: TSizes.iconMd,
              width: TSizes.iconMd,
            ),
          ),
        ),
        const Gap(TSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.facebookLogo),
              height: TSizes.iconMd,
              width: TSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
