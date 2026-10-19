import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      },
      theme: AppTheme.darkTheme,
    );
  }
}