import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/ui/update_profile/widgets/avatar_picker_sheet.dart';

import '../../../core/utils/app_images.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_image_asset.dart';
import '../widget/build.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(
    text: 'John Safwat',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '01200000000',
  );
  int _avatarIndex = 0;
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
        title: Text('Pick Avatar', style: AppStyles.regular16YellowRoboto),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.getWidth(context, 16),
              vertical: SizeUtils.getHeight(context, 33)),
          child: Column(
            spacing: SizeUtils.getHeight(context, 24),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: SizeUtils.getHeight(context, 24),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: buildGestureDetector(
                              onTap: pickAvatar,
                              child: ClipOval(
                                child: CustomImageAsset(
                                  path: AvatarPickerSheet.avatars[_avatarIndex],
                                  width: SizeUtils.getWidth(context, 150),
                                  height: SizeUtils.getHeight(context, 150),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        buildField(
                          prefixIcon: CustomImageAsset(
                            path: AppImages.profileTabImagePath,
                          ),
                          controller: _nameController,
                          validator: (p0) => Validators.validateName(p0),
                        ),
                        buildField(
                          controller: _phoneController,
                          prefixIcon: CustomImageAsset(
                            path: AppImages.phoneIconImagePath,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (p0) => Validators.validatePhoneNumber(p0),
                        ),
                        Text(
                          'Reset Password',
                          style: AppStyles.regular16WhiteRoboto,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildElevatedButton(
                  onPressed: () {},
                  context: context,
                  backgroundColor: AppColors.redColor,
                  child: Text('Delete Account',
                    style: AppStyles.regular16WhiteRoboto,
                  )
              ),
              buildElevatedButton(
                  onPressed: _updateData,
                  context: context,
                  child: Text('Update Data',
                style: AppStyles.regular16DarkGrayRoboto,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickAvatar() async {
    final int? picked = await AvatarPickerSheet.show(
      context,
      selectedIndex: _avatarIndex,
    );
    if (picked == null || !mounted) return;
    setState(() => _avatarIndex = picked);
  }

  void _updateData() {
    if (!_formKey.currentState!.validate()) return;
  }
}