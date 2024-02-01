import 'package:flutter/material.dart';
import 'package:project_med/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:project_med/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:project_med/utils/theme/custom_themes/text_field_theme.dart';
import 'package:project_med/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();  //?private constructor, to make sure that it's not used again and again

  static ThemeData ligtTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}