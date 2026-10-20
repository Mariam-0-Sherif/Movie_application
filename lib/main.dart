import 'package:flutter/material.dart';
import 'package:movie_application/features/ui/auth/forget_password/forget_password_screen.dart';
import 'package:movie_application/features/ui/auth/login/login_screen.dart';
import 'package:movie_application/features/ui/auth/register/register_screen.dart';

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
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
      },
      theme: AppTheme.darkTheme,
    );
  }
}