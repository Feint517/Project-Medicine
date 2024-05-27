import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/user/user_repository.dart';
import 'package:project_med/features/personalization/controllers/user_controller.dart';
import 'package:project_med/features/personalization/screens/profile/profile.dart';
import 'package:project_med/utils/constants/animations.dart';
import 'package:project_med/utils/helpers/network_manager.dart';
import 'package:project_med/utils/popups/fullscreen_loader.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final newPhoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  Future<void> initializePhoneNumber() async {
    newPhoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNumber() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'We are updating your information...',
        TAnimations.check,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* update first name and last name in firestore
      Map<String, dynamic> phoneNumber = {
        'PhoneNumber': newPhoneNumber.text.trim(),
      };
      await userRepository.updateSingleField(phoneNumber);

      //* update the Rx user value
      userController.user.value.phoneNumber = newPhoneNumber.text.trim();

      //* remove loader
      CustomFullscreenLoader.stopLoading();

      //* show success message
      CustomLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated.',
      );

      //* move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
