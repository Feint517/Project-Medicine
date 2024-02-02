import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/common/widgets/login_signup/form_divider.dart';
import 'package:project_med/common/widgets/login_signup/social_buttons.dart';
import 'package:project_med/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //? to make things scrollable on smaller devices
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* title
              Text(
                TTexts.signUpTitile,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(TSizes.spaceBtwSections),

              //* form
              const SignupForm(),
              const Gap(TSizes.spaceBtwSections),

              //* divider
              FormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const Gap(TSizes.spaceBtwSections),

              //* social buttons
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
