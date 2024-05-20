import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_med/app.dart';
import 'package:project_med/data/repositories/authentication_repository.dart';
import 'package:project_med/firebase_options.dart';

Future<void> main() async {
  //* add widgets bindings
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  //! this line ensures that the firebase initialization finishes first, then initialize the design widgets

  //* init local storage
  await GetStorage.init();

  //* await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //* initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) =>
        Get.put(AuthenticationRepository()), //? invoke the authentication repo
  );

  //* initialize authentication

  //* load all the material design,  themes, localisations

  runApp(const App());
}


//! known issues:
//!    - password doesn't update in the firestore when resetting it
//!    - it shows default profile picture while signing in with google instead of actual account picture

