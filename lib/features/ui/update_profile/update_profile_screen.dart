import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/custom_elevated_button.dart';
import 'package:movie_application/core/widgets/custom_text_form_field.dart';
import 'package:movie_application/features/ui/update_profile/widgets/avatar_picker_sheet.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
  );
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

  double w(double value) => SizeUtils.getWidth(context, value);

  double h(double value) => SizeUtils.getHeight(context, value);

  Future<void> _pickAvatar() async {
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
          padding: EdgeInsets.symmetric(horizontal: w(16)),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h(24)),
                        Center(child: _buildAvatar()),
                        SizedBox(height: h(32)),
                        _buildField(
                          controller: _nameController,
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: h(16)),
                        _buildField(
                          controller: _phoneController,
                          icon: Icons.phone,
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
                        Text(
                          'Reset Password',
                          style: AppStyles.regular16WhiteRoboto,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildButton(
                title: 'Delete Account',
                color: AppColors.redColor,
                style: AppStyles.regular16WhiteRoboto,
                onPressed: () {},
              ),
              SizedBox(height: h(16)),
              _buildButton(
                title: 'Update Data',
                color: AppColors.yellowColor,
                style: AppStyles.regular16DarkGrayRoboto,
                onPressed: _updateData,
              ),
              SizedBox(height: h(16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final double size = w(150);
    return GestureDetector(
      onTap: _pickAvatar,
      child: ClipOval(
        child: Image.asset(
          AvatarPickerSheet.avatars[_avatarIndex],
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType type = TextInputType.text,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: type,
      filled: true,
      fillColor: AppColors.darkGreyColor,
      borderSideColor: AppColors.darkGreyColor,
      style: AppStyles.regular16WhiteRoboto,
      prefixIcon: Icon(icon, color: AppColors.whiteColor),
      validator: validator,
    );
  }

  Widget _buildButton({
    required String title,
    required Color color,
    required TextStyle style,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: h(56),
      child: CustomElevatedButton(
        onPressed: onPressed,
        backgroundColor: color,
        radius: w(16),
        child: Text(title, style: style),
      ),
    );
  }
}