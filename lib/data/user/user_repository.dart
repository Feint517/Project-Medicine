import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_med/data/user/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //* function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).set(user.toJson());
    // try {
    //   await _db.collection("Users").doc(user.id).set(user.toJson());
    // } on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // }  on FormatException catch (_) {
    //   throw const TFormatException();
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    // } catch (e) {
    //   throw ('Something went wrong, please try again');
    // }
  }

  //* function to fetch details based on the ID

  //* function to update user data to firestore

  //* update any field in specific users collection
}
