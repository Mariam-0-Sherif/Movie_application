import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

void showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.darkGreyColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: Text('English', style: AppStyles.regular16WhiteRoboto),
              onTap: () {
                // TODO: Switch lang to english
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇪🇬', style: TextStyle(fontSize: 24)),
              title: Text('العربية', style: AppStyles.regular16WhiteRoboto),
              onTap: () {
                // TODO: Switch lang to arabic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
