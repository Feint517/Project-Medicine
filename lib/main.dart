import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/app.dart';
import 'package:project_med/firebase_options.dart';

Future<void> main() async {
  //* add widgets bindings
  //* init local storage
  //* await native splash
  //* initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) =>
        Get.put(AuthenticationRepository()), //? invoke the authentication repo
  );

  //* initialize authentification

  //* load all the material design,  themes, localisations
  runApp(const App());
}
