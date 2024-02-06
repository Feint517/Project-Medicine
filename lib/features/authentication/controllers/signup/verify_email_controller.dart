import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/common/widgets/success_screen/success_screen.dart';
import 'package:project_med/data/repositories/authentication_repository.dart';
import 'package:project_med/utils/constants/animations.dart';
import 'package:project_med/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //* send email whenever verify screen appear and set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //* send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      CustomLoaders.successSnackBar(
        title: 'Email sent',
        message: 'Please check your inbox and verify your email',
      );
    } catch (e) {
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //* timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    //? after each second, execute the following function
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubtitle,
              image: TAnimations.success,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  //* check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubtitle,
          image: TAnimations.success,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
