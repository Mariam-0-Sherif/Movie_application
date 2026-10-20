import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/app_routes.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/custom_elevated_button.dart';
import 'package:movie_application/core/widgets/custom_text_form_field.dart';
import 'package:movie_application/core/widgets/language_switch.dart';

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

  List<String> avatars = [
    AppImages.profileAvatar1ImagePath,
    AppImages.profileAvatar2ImagePath,
    AppImages.profileAvatar3ImagePath,
  ];
  int selectedAvatar = 1;

  double w(double value) => SizeUtils.getWidth(context, value);

  double h(double value) => SizeUtils.getHeight(context, value);

  void createAccount() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget buildField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType type = TextInputType.text,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: type,
      filled: true,
      fillColor: AppColors.darkGreyColor,
      borderSideColor: AppColors.darkGreyColor,
      style: TextStyle(color: AppColors.whiteColor, fontSize: w(16)),
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.whiteColor, fontSize: w(16)),
      prefixIcon: Icon(icon, color: AppColors.whiteColor),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.yellowColor),
        ),
        title: Text(
          'Register',
          style: TextStyle(color: AppColors.yellowColor, fontSize: w(16)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: h(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < avatars.length; i++)
                    GestureDetector(
                      onTap: () {
                        selectedAvatar = i;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(6)),
                        child: Image.asset(
                          avatars[i],
                          width: i == selectedAvatar ? w(158) : w(90),
                          height: i == selectedAvatar ? w(158) : w(90),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: h(8)),
              Text(
                'Avatar',
                style: TextStyle(color: AppColors.whiteColor, fontSize: w(14)),
              ),
              SizedBox(height: h(24)),
              buildField(
                hint: 'Name',
                icon: Icons.person,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: h(16)),
              buildField(
                hint: 'Email',
                icon: Icons.email,
                controller: emailController,
                type: TextInputType.emailAddress,
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
              SizedBox(height: h(16)),
              CustomTextFormField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                filled: true,
                fillColor: AppColors.darkGreyColor,
                borderSideColor: AppColors.darkGreyColor,
                style: TextStyle(color: AppColors.whiteColor, fontSize: w(16)),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: w(16),
                ),
                prefixIcon: const Icon(Icons.lock, color: AppColors.whiteColor),
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
              SizedBox(height: h(16)),
              CustomTextFormField(
                controller: confirmPasswordController,
                obscureText: isConfirmPasswordHidden,
                filled: true,
                fillColor: AppColors.darkGreyColor,
                borderSideColor: AppColors.darkGreyColor,
                style: TextStyle(color: AppColors.whiteColor, fontSize: w(16)),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: w(16),
                ),
                prefixIcon: const Icon(Icons.lock, color: AppColors.whiteColor),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: h(16)),
              buildField(
                hint: 'Phone Number',
                icon: Icons.phone,
                controller: phoneController,
                type: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 11) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: h(24)),
              SizedBox(
                width: double.infinity,
                height: h(56),
                child: CustomElevatedButton(
                  onPressed: createAccount,
                  backgroundColor: AppColors.yellowColor,
                  radius: w(16),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: w(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ?',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: w(14),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.yellowColor,
                        fontSize: w(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h(5)),
              const LanguageSwitch(),
              SizedBox(height: h(16)),
            ],
          ),
        ),
      ),
    );
  }
}
