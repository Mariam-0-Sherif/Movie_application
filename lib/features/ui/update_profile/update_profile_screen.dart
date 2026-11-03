import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/ui/update_profile/widgets/avatar_picker_sheet.dart';

import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widget/custom_image_asset.dart';
import '../../common/widget/app_button.dart';
import '../../common/widget/app_text_field.dart';
import '../home/tabs/profile_tab/cubit/profile_cubit.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late int _avatarIndex;

  @override
  void initState() {
    super.initState();
    final profile = context
        .read<ProfileCubit>()
        .state;
    _nameController = TextEditingController(text: profile.name);
    _phoneController = TextEditingController(text: profile.phone);
    _avatarIndex = profile.avatarIndex;
  }
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
                            child: GestureDetector(
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
                        AppTextField(
                          prefixIcon: CustomImageAsset(
                            path: AppImages.profileTabImagePath,
                          ),
                          controller: _nameController,
                          validator: (p0) => Validators.validateName(p0),
                        ),
                        AppTextField(
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
              AppButton(
                  onPressed: deleteAccount,
                  backgroundColor: AppColors.redColor,
                  child: Text('Delete Account',
                    style: AppStyles.regular16WhiteRoboto,
                  )
              ),
              AppButton(
                  onPressed: _updateData,
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

  Future<void> _updateData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await context.read<ProfileCubit>().update(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        avatarIndex: _avatarIndex,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  Future<void> deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Delete Account'),
            content: const Text('Are you sure? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
    if (confirmed != true) return;

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      await user.delete();

      if (!mounted) return;

      context.read<ProfileCubit>().reset();

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginRouteName,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final msg = e.code == 'requires-recent-login'
          ? 'Please log out and log in again, then try deleting your account'
          : (e.message ?? 'Delete failed');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Delete failed')),
      );
    }
  }
}