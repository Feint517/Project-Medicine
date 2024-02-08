import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/repositories/authentication_repository.dart';
import 'package:project_med/data/user/user_model.dart';
import 'package:project_med/data/user/user_repository.dart';
import 'package:project_med/features/authentication/screens/login/login.dart';
import 'package:project_med/features/personalization/screens/profile/re_authenticate_user_login_form.dart';
import 'package:project_med/utils/constants/animations.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/network_manager.dart';
import 'package:project_med/utils/popups/fullscreen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecords();
  }

  //? fetch user record from any regestration provider
  Future<void> fetchUserRecords() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      //? this.user -> Rx<UserModel> user
      //? pass the details of the current user to this one
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //? save user records from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //* refresh user record
      await fetchUserRecords();

      //* if no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //* convert Name to First Name and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //* map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            password: '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //* save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      CustomLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your data.',
      );
    }
  }

  //? delete account warning
  void deletaAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete account',
      middleText:
          'Are you sure you awnt to delete your account? This action cannot be undone',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccouont(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //? delete user
  void deleteUserAccouont() async {
    try {
      CustomFullscreenLoader.openLoadingDialog('Processing', TAnimations.check);

      //* re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first; //? can be googole or password
      if (provider.isNotEmpty) {
        //*re verifiy email auth
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          CustomFullscreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          CustomFullscreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //? re-authenticate before deleting
  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      CustomFullscreenLoader.openLoadingDialog('Processing', TAnimations.check);

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!reAuthFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await AuthenticationRepository.instance.deleteAccount();
      CustomFullscreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //? upload profile image
  uploadUserProfilePicture() async {
    try {
      //? allow the user to open the gallery and choose the image he wants
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        //*upload image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //* update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;

        user.refresh();

        CustomLoaders.successSnackBar(
          title: 'Congratulation',
          message: 'Your profile image has been updated',
        );
      }
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
