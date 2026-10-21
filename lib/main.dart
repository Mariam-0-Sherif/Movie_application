import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/features/ui/auth/forget_password/forget_password_screen.dart';
import 'package:movie_application/features/ui/auth/login/login_screen.dart';
import 'package:movie_application/features/ui/auth/register/register_screen.dart';
import 'features/ui/home/home_screen.dart';
import 'features/ui/update_profile/update_profile_screen.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'features/ui/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
      },
      theme: AppTheme.darkTheme,
    );
  }
}