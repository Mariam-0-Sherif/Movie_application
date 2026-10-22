import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/features/ui/widget/build.dart';

import '../../../core/utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String errorMessage;

  const MainErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: SizeUtils.getHeight(context, 15),
      children: [
        Text(errorMessage, style: AppStyles.regular16WhiteRoboto),
        buildElevatedButton(
          onPressed: onPressed,
          context: context,
          child: Text(
            'Please Try again',
            style: AppStyles.regular16BlackRoboto,
          ),
        ),
      ],
    );
  }
}
