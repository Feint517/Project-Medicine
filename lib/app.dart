import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/bindings/general_bindings.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.ligtTheme,
      darkTheme: TAppTheme.darkTheme,
      //? when the app runs, it will automatically initiate all the methods in GeneralBindings
      initialBinding: GeneralBindings(), 
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
