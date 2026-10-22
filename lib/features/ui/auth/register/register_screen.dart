import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/validators.dart';
import 'package:movie_application/core/widgets/custom_image_asset.dart';
import 'package:movie_application/features/ui/auth/register/widget/choose_avatar.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/size_utils.dart';
import '../../widget/build.dart';
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
              buildField(
                hint: 'Name',
                prefixIcon: CustomImageAsset(path: AppImages.nameIconImagePath),
                controller: nameController,
                validator: (p0) => Validators.validateName(p0),
              ),
              buildField(
                hint: 'Email',
                prefixIcon: CustomImageAsset(
                  path: AppImages.emailIconImagePath,
                ),
                controller: emailController,
                validator: (p0) => Validators.validateEmail(p0),
              ),
              buildField(
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
              buildField(
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
              buildField(
                hint: 'Phone Number',
                prefixIcon: CustomImageAsset(
                  path: AppImages.phoneIconImagePath,
                ),
                controller: phoneController,
                validator: (p0) => Validators.validatePhoneNumber(p0),
                keyboardType: TextInputType.phone,
              ),
              buildElevatedButton(
                onPressed: createAccount,
                context: context,
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
  void createAccount() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    }
  }
}
