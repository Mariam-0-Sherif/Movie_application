import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/validators.dart';
import 'package:movie_application/features/ui/auth/login/widget/divider_or_divider.dart';
import 'package:movie_application/features/ui/auth/widget/bottom_sheet.dart';
import 'package:movie_application/features/ui/auth/widget/build.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

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
                SizedBox(height: SizeUtils.getHeight(context, 40)),
                CustomImageAsset(
                  path: AppImages.logoAppImagePath,
                  height: SizeUtils.getHeight(context, 100),
                ),
                SizedBox(height: SizeUtils.getHeight(context, 40)),
                buildField(
                  prefixIcon: CustomImageAsset(
                    path: AppImages.emailIconImagePath,
                  ),
                  controller: emailController,
                  hint: 'Email',
                  validator: (p0) => Validators.validateEmail(p0),
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
                      isPasswordHidden = !isPasswordHidden;
                      setState(() {});
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  validator: (p0) => Validators.validatePassword(p0),
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
                  child: Text('Login', style: AppStyles.regular20BlackRoboto),
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
                  onPressed: () {
                    /// todo: Login With Google
                  },
                  child: Row(
                    spacing: SizeUtils.getWidth(context, 24),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIconImagePath),
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
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    }
  }
}
