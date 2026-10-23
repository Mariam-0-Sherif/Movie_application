import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/validators.dart';
import 'package:movie_application/features/common/widget/custom_image_asset.dart';
import 'package:movie_application/features/ui/auth/register/widget/choose_avatar.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../common/widget/app_button.dart';
import '../../../common/widget/app_text_field.dart';
import '../widget/bottom_sheet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  int selectedAvatar = 1;
  late final PageController avatarController = PageController(
    viewportFraction: 0.36,
    initialPage: selectedAvatar,
  );
  List<String> avatars = [
    AppImages.profileAvatar1ImagePath,
    AppImages.profileAvatar2ImagePath,
    AppImages.profileAvatar3ImagePath,
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.yellowColor),
        ),
        title: Text('Register', style: AppStyles.regular16YellowRoboto),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.getWidth(context, 16),
        ),
        child: Form(
          key: formKey,
          child: Column(
            spacing: SizeUtils.getHeight(context, 13),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChooseAvatar(
                avatars: avatars,
                avatarController: avatarController,
                onAvatarChanged: (index) => selectedAvatar = index,
              ),
              Text(
                'Avatar',
                style: AppStyles.regular16WhiteRoboto,
                textAlign: TextAlign.center,
              ),
              AppTextField(
                hint: 'Name',
                prefixIcon: CustomImageAsset(path: AppImages.nameIconImagePath),
                controller: nameController,
                validator: (p0) => Validators.validateName(p0),
              ),
              AppTextField(
                hint: 'Email',
                prefixIcon: CustomImageAsset(
                  path: AppImages.emailIconImagePath,
                ),
                controller: emailController,
                validator: (p0) => Validators.validateEmail(p0),
              ),
              AppTextField(
                hint: 'Password',
                prefixIcon: CustomImageAsset(
                  path: AppImages.passwordIconImagePath,
                ),
                controller: passwordController,
                obscureText: isPasswordHidden,
                validator: (p0) => Validators.validatePassword(p0),
                suffixIcon: IconButton(
                  onPressed: () {
                    isPasswordHidden = !isPasswordHidden;
                    setState(() {});
                  },
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              AppTextField(
                hint: 'Confirm Password',
                prefixIcon: CustomImageAsset(
                  path: AppImages.passwordIconImagePath,
                ),
                controller: confirmPasswordController,
                obscureText: isConfirmPasswordHidden,
                validator: (p0) => Validators.validateConfirmPassword(
                  p0,
                  passwordController.text,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    isConfirmPasswordHidden = !isConfirmPasswordHidden;
                    setState(() {});
                  },
                  icon: Icon(
                    isConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              AppTextField(
                hint: 'Phone Number',
                prefixIcon: CustomImageAsset(
                  path: AppImages.phoneIconImagePath,
                ),
                controller: phoneController,
                validator: (p0) => Validators.validatePhoneNumber(p0),
                keyboardType: TextInputType.phone,
              ),
              AppButton(
                onPressed: createAccount,
                child: Text(
                  'Create Account',
                  style: AppStyles.regular20BlackRoboto,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ?',
                    style: AppStyles.regular14WhiteRoboto,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Login', style: AppStyles.black14YellowRoboto),
                  ),
                ],
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
    );
  }

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
      final user = credential.user!;
      await user.updateDisplayName(nameController.text.trim());
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatar': selectedAvatar,
      });
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeRouteName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('REGISTER ERROR: ${e.code} - ${e.message}');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Register failed')));
    } on FirebaseException catch (e) {
      debugPrint('FIRESTORE ERROR: ${e.code} - ${e.message}');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saving data failed: ${e.message}')),
      );
    }
  }
}
