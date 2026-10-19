import 'package:flutter/material.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'features/ui/onboarding/onboarding_screen.dart';

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
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
      },
      theme: AppTheme.darkTheme,
    );
  }
}