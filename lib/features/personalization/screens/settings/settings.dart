import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:project_med/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:project_med/data/repositories/authentication_repository.dart';
import 'package:project_med/features/personalization/screens/profile/profile.dart';
import 'package:project_med/common/widgets/misc/custom_section_heading.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* header
            CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections),

                  //* user profile card
                  UserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),

            //* body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //* account settings
                  const CustomSectionHeading(
                    title: "Account",
                    showActionButton: false,
                  ),
                  const Gap(TSizes.spaceBtwItems),

                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My address",
                    subtitle: "idk what to say",
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "Name",
                    subtitle: "idk what to say",
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "Security",
                    subtitle: "idk what to say",
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "idk",
                    subtitle: "idk what to say",
                    onTap: () {},
                  ),

                  //* app Setting
                  const Gap(TSizes.spaceBtwSections),
                  const CustomSectionHeading(
                    title: "App setting",
                    showActionButton: false,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  SettingsMenuTile(
                    icon: Iconsax.document,
                    title: "Data",
                    subtitle: "idk what to say",
                    onTap: () {},
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  SettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Location",
                    subtitle: "idk what to say",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.sun,
                    title: "Color Mode",
                    subtitle: "idk what to say",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  //* Logout button
                  const Gap(TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthenticationRepository.instance.logout(),
                      child: const Text('Log out'),
                    ),
                  ),
                  const Gap(TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


