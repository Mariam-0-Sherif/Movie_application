import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_image_asset.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
        title: Text('Forget Password', style: AppStyles.regular16YellowRoboto),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.getWidth(context, 16),
        ),
        child: Form(
          key: formKey,
          child: Column(
            spacing: SizeUtils.getHeight(context, 24),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppImages.forgetPassImagePath),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                filled: true,
                fillColor: AppColors.darkGreyColor,
                borderSideColor: AppColors.darkGreyColor,
                cursorColor: AppColors.whiteColor,
                style: AppStyles.regular16WhiteRoboto,
                hintText: 'Email',
                hintStyle: AppStyles.regular16WhiteRoboto,
                prefixIcon: CustomImageAsset(
                  path: AppImages.emailIconImagePath,
                ),
                validator: (p0) => Validators.validateEmail(p0),
              ),
              CustomElevatedButton(
                onPressed: () {},
                backgroundColor: AppColors.yellowColor,
                radius: SizeUtils.getWidth(context, 15),
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.getHeight(context, 12),
                ),
                child: Text(
                  'Verify Email',
                  style: AppStyles.regular20BlackRoboto,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
