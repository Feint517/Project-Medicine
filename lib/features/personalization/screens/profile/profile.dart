import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/circular_image.dart';
import 'package:project_med/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:project_med/features/personalization/screens/settings/settings.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    //* profile picture
                    const CustomCircularImage(
                      image: TImages.avatar,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Porfile Picture'),
                    ),
                  ],
                ),
              ),

              //* details
              const Gap(TSizes.spaceBtwItems / 2),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),

              //* heading profile info
              const CustomSectionHeading(
                title: "Profile information",
                showActionButton: false,
              ),
              const Gap(TSizes.spaceBtwItems),

              CustomProfileMenu(
                title: 'Name',
                value: 'Arselene.dev',
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: 'Username',
                value: 'Feint517',
                onPressed: () {},
              ),

              const Gap(TSizes.spaceBtwItems),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),

              //* heading personal info
              const CustomSectionHeading(
                  title: "Personal Information", showActionButton: false),
              const Gap(TSizes.spaceBtwItems),

              CustomProfileMenu(
                title: "User ID",
                value: "15484664847",
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Email",
                value: "test@gmail.com",
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Phone",
                value: "0564971584",
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Gender",
                value: "Male",
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Date of birth",
                value: "August 13, 2003",
                onPressed: () {},
              ),

              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              SizedBox(
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
