import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_routes.dart';
import 'package:movie_application/core/utils/app_theme.dart';
import 'package:movie_application/features/ui/auth/forget_password/forget_password_screen.dart';
import 'package:movie_application/features/ui/auth/login/login_screen.dart';
import 'package:movie_application/features/ui/auth/register/register_screen.dart';
import 'package:movie_application/features/ui/onboarding/onboarding_screen.dart';

import 'features/ui/home/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
      },
    );
  }
}
