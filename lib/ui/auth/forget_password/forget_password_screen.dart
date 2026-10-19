import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/ui/widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_images.dart';
import 'package:movie_app/utils/size_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  // function mo5tasara bta5od raqam el Figma w trg3o 3ala 7asab 3ard el screen
  double w(double value) => SizeUtils.getWidth(context, value);

  // nafs el fekra bas lel tool
  double h(double value) => SizeUtils.getHeight(context, value);

  // zorar Verify Email: delwa2ty bas bn3mel validate, el Firebase b3dein
  void verifyEmail() {
    if (formKey.currentState!.validate()) {
      // TODO: ba3t email el reset 3an tare2 Firebase
    }
  }

  @override
  void dispose() {
    emailController.dispose();
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
        title: Text(
          'Forget Password',
          style: TextStyle(color: AppColors.yellowColor, fontSize: w(16)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: h(40)),

              // el soura el kebeera
              Image.asset(
                AppImages.forgetPasswordImagePath,
                width: double.infinity,
                height: h(400),
                fit: BoxFit.contain,
              ),

              SizedBox(height: h(24)),

              // field el email
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                filled: true,
                fillColor: AppColors.darkGreyColor,
                borderSideColor: AppColors.darkGreyColor,
                style: TextStyle(color: AppColors.whiteColor, fontSize: w(16)),
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

              // zorar Verify Email
              SizedBox(
                width: double.infinity,
                height: h(56),
                child: CustomElevatedButton(
                  onPressed: verifyEmail,
                  backgroundColor: AppColors.yellowColor,
                  radius: w(16),
                  child: Text(
                    'Verify Email',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: w(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
