import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/common/widgets/appbar/appbar.dart';
import 'package:project_med/common/widgets/custon_shapes/container/circular_image.dart';
import 'package:project_med/common/widgets/loaders/shimmer.dart';
import 'package:project_med/common/widgets/misc/custom_section_heading.dart';
import 'package:project_med/features/personalization/controllers/user_controller.dart';
import 'package:project_med/features/personalization/screens/profile/change_name.dart';
import 'package:project_med/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:project_med/utils/constants/image_strings.dart';
import 'package:project_med/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
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
                    Obx(() {
                      final networkImage = controller.user.value
                          .profilePicture; //? check if there's a profile picture in the user model
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.avatar;

                      return controller.imageUploading.value
                          ? const CustomShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : CustomCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
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
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeNameScreen()),
              ),
              CustomProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
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
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onPressed: () {},
              ),
              CustomProfileMenu(
                title: "Phone",
                value: controller.user.value.phoneNumber,
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
                    onPressed: () => controller.deletaAccountWarningPopup(),
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
