import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/ui/widgets/custom_text_form_field.dart';
import 'package:movie_app/ui/widgets/divider_item.dart';
import 'package:movie_app/ui/widgets/language_switch.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_images.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/size_utils.dart';

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

  double w(double value) => SizeUtils.getWidth(context, value);

  double h(double value) => SizeUtils.getHeight(context, value);

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    }
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
          padding: EdgeInsets.symmetric(horizontal: w(16)),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: h(60)),
                Image.asset(AppImages.logoImagePath, width: w(120)),
                SizedBox(height: h(60)),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  filled: true,
                  fillColor: AppColors.darkGreyColor,
                  borderSideColor: AppColors.darkGreyColor,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: w(16),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: w(16),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.whiteColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: h(24)),
                CustomTextFormField(
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  filled: true,
                  fillColor: AppColors.darkGreyColor,
                  borderSideColor: AppColors.darkGreyColor,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: w(16),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: w(16),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.whiteColor,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
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
                      style: TextStyle(
                        color: AppColors.yellowColor,
                        fontSize: w(14),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h(16)),
                SizedBox(
                  width: double.infinity,
                  height: h(56),
                  child: CustomElevatedButton(
                    onPressed: login,
                    backgroundColor: AppColors.yellowColor,
                    radius: w(16),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: w(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account ?",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: w(14),
                      ),
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
                        style: TextStyle(
                          color: AppColors.yellowColor,
                          fontSize: w(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h(16)),
                Row(
                  children: [
                    DividerItem(color: AppColors.yellowColor, indent: w(40)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(12)),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: AppColors.yellowColor,
                          fontSize: w(16),
                        ),
                      ),
                    ),
                    DividerItem(color: AppColors.yellowColor, endIndent: w(40)),
                  ],
                ),
                SizedBox(height: h(24)),
                SizedBox(
                  width: double.infinity,
                  height: h(56),
                  child: CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: AppColors.yellowColor,
                    radius: w(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.googleImagePath, width: w(24)),
                        SizedBox(width: w(12)),
                        Text(
                          'Login With Google',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: w(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: h(24)),
                const LanguageSwitch(),
                SizedBox(height: h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
