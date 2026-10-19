import 'package:flutter/material.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {},
      theme: AppTheme.darkTheme,
    );
  }
}
