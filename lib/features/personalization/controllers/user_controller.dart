import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_med/common/styles/loaders.dart';
import 'package:project_med/data/user/user_model.dart';
import 'package:project_med/data/user/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  //* save user records from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        //* convert Name to First Name and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        //* map data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          password: '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        //* save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      CustomLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your data.',
      );
    }
  }
}
