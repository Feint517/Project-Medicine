import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_med/common/styles/spacing_styles.dart';
import 'package:project_med/common/widgets/login_signup/form_divider.dart';
import 'package:project_med/common/widgets/login_signup/social_buttons.dart';
import 'package:project_med/features/authentication/screens/login/widgets/login_form.dart';
import 'package:project_med/features/authentication/screens/login/widgets/login_header.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //? to make the design scrollable for smaller screens, we use SingleChildScrollView
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //? logo, title, subtitle
              const LoginHeader(),

              //? form
              const LoginForm(),

              //? devider
              FormDivider(
                dividerText: TTexts.orSignInWith.capitalize!,
              ),
              const Gap(TSizes.spaceBtwSections),

              //? footer
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
