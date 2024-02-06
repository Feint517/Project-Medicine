import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/authentication/controllers/signup/signup_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/text_strings.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class TermsAndConditionsCheckBox extends StatelessWidget {
  const TermsAndConditionsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${TTexts.iAgreeTo} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.privacy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? Colors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? Colors.white : TColors.primary,
                    ),
              ),
              TextSpan(
                text: " ${TTexts.and}  ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.terms,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? Colors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? Colors.white : TColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
