import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_routes.dart';
import 'package:movie_application/home/home_screen.dart';
import 'package:movie_application/ui/auth/forget_password/forget_password_screen.dart';
import 'package:movie_application/ui/auth/login/login_screen.dart';
import 'package:movie_application/ui/auth/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.blackColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blackColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => const HomeScreen(),
        AppRoutes.loginRouteName: (context) => const LoginScreen(),
        AppRoutes.registerRouteName: (context) => const RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) =>
            const ForgetPasswordScreen(),
      },
    );
  }
}
