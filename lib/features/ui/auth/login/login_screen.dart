
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/validators.dart';
import 'package:movie_application/features/ui/auth/login/widget/divider_or_divider.dart';
import 'package:movie_application/features/ui/auth/widget/bottom_sheet.dart';
import 'package:movie_application/features/ui/widget/build.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/widgets/custom_image_asset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController();
  final TextEditingController passwordController =
  TextEditingController();

  bool isPasswordHidden = true;
  bool isGoogleLoading = false;

  late final Future<void> _googleSignInInit;

  @override
  void initState() {
    super.initState();

    _googleSignInInit = GoogleSignIn.instance.initialize(
      serverClientId: 'YOUR_WEB_OAUTH_CLIENT_ID',
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.getWidth(context, 19),
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: SizeUtils.getHeight(context, 17),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: SizeUtils.getHeight(context, 40),
                ),
                CustomImageAsset(
                  path: AppImages.logoAppImagePath,
                  height: SizeUtils.getHeight(context, 100),
                ),
                SizedBox(
                  height: SizeUtils.getHeight(context, 40),
                ),
                buildField(
                  prefixIcon: CustomImageAsset(
                    path: AppImages.emailIconImagePath,
                  ),
                  controller: emailController,
                  hint: 'Email',
                  validator: (value) =>
                      Validators.validateEmail(value),
                ),
                buildField(
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  hint: 'Password',
                  prefixIcon: CustomImageAsset(
                    path: AppImages.passwordIconImagePath,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  validator: (value) =>
                      Validators.validatePassword(value),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.forgetPasswordRouteName,
                      );
                    },
                    child: Text(
                      'Forget Password ?',
                      style: AppStyles.regular14YellowRoboto,
                    ),
                  ),
                ),
                buildElevatedButton(
                  onPressed: login,
                  child: Text(
                    'Login',
                    style: AppStyles.regular20BlackRoboto,
                  ),
                  context: context,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account ?",
                      style: AppStyles.regular14WhiteRoboto,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.registerRouteName,
                        );
                      },
                      child: Text(
                        'Create One',
                        style: AppStyles.black14YellowRoboto,
                      ),
                    ),
                  ],
                ),
                DividerOrDivider(),
                buildElevatedButton(
                  onPressed: isGoogleLoading
                      ? null
                      : signInWithGoogle,
                  child: isGoogleLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Row(
                    spacing: SizeUtils.getWidth(context, 24),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.googleIconImagePath,
                      ),
                      Text(
                        'Login With Google',
                        style: AppStyles.regular16BlackRoboto,
                      ),
                    ],
                  ),
                  context: context,
                ),
                CustomImageAsset(
                  path: AppImages.languageSwitchIconImagePath,
                  onTap: () {
                    showLanguageSheet(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeRouteName,
            (route) => false,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    if (!mounted) return;

    debugPrint('GOOGLE LOGIN SUCCESS');
    debugPrint('HOME ROUTE: ${AppRoutes.homeRouteName}');

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.homeRouteName,
          (route) => false,
    );
    if (isGoogleLoading) return;

    setState(() {
      isGoogleLoading = true;
    });

    try {
      await _googleSignInInit;

      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final AuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (!mounted) return;

      if (userCredential.user == null) {
        throw Exception('Firebase did not return a signed-in user.');
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeRouteName,
            (route) => false,
      );
    } catch (e, stackTrace) {
      debugPrint('Google sign-in error: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Login failed: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isGoogleLoading = false;
        });
      }
    }
  }
}
