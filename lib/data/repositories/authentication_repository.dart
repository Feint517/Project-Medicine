import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_med/features/authentication/screens/login/login.dart';
import 'package:project_med/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project_med/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:project_med/utils/exceptions/firebase_exceptions.dart';
import 'package:project_med/utils/exceptions/format_exceptions.dart';
import 'package:project_med/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //* function to show relevant screen
  screenRedirect() async {
    //* local storage

    if (kDebugMode) {
      print("================ Get Storage AUTH REPO ================");
      print(deviceStorage.read('isFirstTime'));
    }

    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnBoardingScreen());
  }

  //--------------------------Email and Password authentication----------------------------
  //* [Email authentication] - register
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // try {
    //   return await _auth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   throw TFirebaseAuthException(e.code).message;
    // } on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // } on FormatException catch (_) {
    //   throw const TFormatException();
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    // } catch (e) {
    //   throw ('Something went wrong, please try again');
    // }
  }

  //* [Email verification] - email verification
  Future<void> sendEmailVerification() async {
    try {
    await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  //* [Email authentication] - signin

  //* [Email authentication] - Reauthenticate user

  //* [Re-authentication] - signin

  //* [Email authentication] - forget password
}
