import 'package:flutter/material.dart';
import 'package:project_med/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.ligtTheme,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}